import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../providers/ble_provider.dart';
import '../models/uuids.dart';

class ControlScreen extends StatefulWidget {
  // const ControlScreen({Key? key}) : super(key: key);
  static const routeName = '/control_screen';
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  void _writeToChar(BluetoothCharacteristic characteristic, int value) async {
    await characteristic.write(_convertIntToBytes(value));
  }

  List<int> _convertIntToBytes(int value) {
    int byte1 = value & 0xff;
    int byte2 = (value >> 8) & 0xff;
    return [byte1, byte2];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final containerHeight = (screenSize.height / 3) - 50;
    return WillPopScope(
      onWillPop: () async {
        print("trigger");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Helpsole App"),
        ),
        body: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff82c2d1),
                Color(0xffdd8f91),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: containerHeight,
                // width: 0,
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width - (screenSize.width - 70),
                      vertical: screenSize.height - (screenSize.height - 30)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      _writeToChar(
                        Provider.of<BleProvider>(context, listen: false)
                            .findByName(Uuid.charControl),
                        1,
                      );
                    },
                    icon: Icon(
                      Icons.addchart,
                      size: 40,
                    ),
                    label: Text(
                      "Start recording",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                height: containerHeight,
                // margin: EdgeInsets.all(20),
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width - (screenSize.width - 70),
                      vertical: screenSize.height - (screenSize.height - 30)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      _writeToChar(
                        Provider.of<BleProvider>(context, listen: false)
                            .findByName(Uuid.charControl),
                        0,
                      );
                    },
                    icon: Icon(
                      Icons.stop_circle_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                    label: Text(
                      "Stop recording",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                height: containerHeight,
                // margin: EdgeInsets.all(20),
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width - (screenSize.width - 70),
                      vertical: screenSize.height - (screenSize.height - 30)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      _writeToChar(
                        Provider.of<BleProvider>(context, listen: false)
                            .findByName(Uuid.charControl),
                        2,
                      );
                    },
                    icon: Icon(
                      Icons.tune,
                      color: Colors.black54,
                      size: 40,
                    ),
                    label: Text(
                      "Calibrate",
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
