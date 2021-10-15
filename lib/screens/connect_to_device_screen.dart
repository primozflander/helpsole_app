// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../widgets/ble_helpers.dart';

import '../providers/ble_provider.dart';
import './control_screen.dart';
import '../models/uuids.dart';

class ConnectToDeviceScreen extends StatefulWidget {
  static const routeName = '/connect_to_device_screen';
  @override
  _ConnectToDeviceScreenState createState() => _ConnectToDeviceScreenState();
}

class _ConnectToDeviceScreenState extends State<ConnectToDeviceScreen> {
  bool _isReady = false;
  bool _isLoading = false;
  Stream<List<int>> stream;
  StreamController<List<int>> _streamController =
      StreamController<List<int>>.broadcast();
  StreamSubscription<BluetoothDeviceState> bleConnectionStateSubscription;

  Future _connectToDevice(BluetoothDevice device) async {
    await device.connect(autoConnect: false, timeout: Duration(seconds: 5));
    _addConnectionListener(device);
  }

  Future _discoverServices(BluetoothDevice device) async {
    final bleCharProvider = Provider.of<BleProvider>(context, listen: false);
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == Uuid.helpsoleService) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          // if (characteristic.uuid.toString() == Uuid.dataStream) {
          //   bleCharProvider.addBleChar(Uuid.dataStream, characteristic);
          //   await characteristic.setNotifyValue(!characteristic.isNotifying);
          //   await device.requestMtu(64).then(
          //     (value) {
          //       stream = characteristic.value;
          //       _streamController.addStream(stream);
          //       Provider.of<BleProvider>(context, listen: false)
          //           .setStreamController(_streamController);
          //       _isReady = true;
          //     },
          //   );
          if (characteristic.uuid.toString() == Uuid.charControl) {
            bleCharProvider.addBleChar(Uuid.charControl, characteristic);
            print("char found-------------------");
          }
        }
        _isReady = true;
        print("in the loop-------------------");
        // print(bleCharProvider.bleChars);
      }
    }
    if (_isReady) {
      Navigator.of(context).pushNamed(ControlScreen.routeName);
    } else {
      print("----------here----------$_isReady");
      device.disconnect();
    }
  }

  void _addConnectionListener(device) {
    bleConnectionStateSubscription = device.state.listen(
      (connectionState) async {
        print('Event: BLE conection state state: $connectionState');
        if (connectionState == BluetoothDeviceState.disconnected) {
          await bleConnectionStateSubscription.cancel();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => ConnectToDeviceScreen()),
              ModalRoute.withName(ConnectToDeviceScreen.routeName));
          setState(() {
            _isLoading = false;
          });
        }
        if (connectionState == BluetoothDeviceState.connected) {
          await _discoverServices(device);
          setState(() {
            _isLoading = false;
          });
        }
      },
    );
  }

  void _selectDevice(BluetoothDevice device) {
    setState(() {
      _isLoading = true;
    });
    _connectToDevice(device);
  }

  @override
  void initState() {
    print('<connect to device screen init>');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Connect",
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Text(
                "Connect",
              ),
            ],
          ),
        ),
      );
    } else {
      return FindDevicesScreen(_selectDevice);
    }
  }
}
