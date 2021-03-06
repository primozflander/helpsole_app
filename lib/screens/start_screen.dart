import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../screens/connect_to_device_screen.dart';
import '../widgets/ble_helpers.dart';

class BLECheckScreen extends StatelessWidget {
  const BLECheckScreen({Key key}) : super(key: key);
  static const routeName = '/start_screen';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothState.on) {
          return const ConnectToDeviceScreen();
        }
        return BluetoothOffScreen(state: state);
      },
    );
  }
}
