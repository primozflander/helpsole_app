import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:provider/provider.dart';

import './screens/control_screen.dart';
import './providers/ble_provider.dart';
import './screens/start_screen.dart';
import './screens/connect_to_device_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BleProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Helpsole App',
        theme: ThemeData(
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.cyan, secondary: Colors.redAccent),
          // primarySwatch: Colors.cyan,
          fontFamily: 'Quicksand',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // ),
        // home: const MyHomePage(title: 'Main'),
        initialRoute: ControlScreen.routeName,
        routes: {
          ControlScreen.routeName: (context) => ControlScreen(),
          BLECheckScreen.routeName: (context) => BLECheckScreen(),
          ConnectToDeviceScreen.routeName: (context) => ConnectToDeviceScreen(),
        },
      ),
    );
  }
}
