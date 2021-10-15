import 'dart:typed_data';
import 'package:flutter/services.dart';

class Functions {
  static List<int> convertIntToBytes(int value) {
    int byte1 = value & 0xff;
    int byte2 = (value >> 8) & 0xff;
    return [byte1, byte2];
  }

  static Map<String, dynamic> parseStream(List<dynamic> dataFromDevice) {
    var data = ByteData.view(Uint8List.fromList(dataFromDevice).buffer);
    if (data.lengthInBytes == 48) {
      return {
        'timestamp': data.getUint16(0, Endian.little),
        'tipSensorValue': data.getInt16(2, Endian.little),
        'fingerSensorValue': data.getInt16(4, Endian.little),
        'angle': data.getInt16(6, Endian.little).abs(),
        'speed': data.getInt16(8, Endian.little),
        'batteryLevel': data.getInt16(10, Endian.little),
        'secondsInRange': data.getInt16(12, Endian.little),
        'secondsInUse': data.getInt16(14, Endian.little),
        'tipSensorUpperRange': data.getInt16(16, Endian.little),
        'tipSensorLowerRange': data.getInt16(18, Endian.little),
        'fingerSensorUpperRange': data.getInt16(20, Endian.little),
        'fingerSensorLowerRange': data.getInt16(22, Endian.little),
        'accX': data.getFloat32(24, Endian.little),
        'accY': data.getFloat32(28, Endian.little),
        'accZ': data.getFloat32(32, Endian.little),
        'gyroX': data.getFloat32(36, Endian.little),
        'gyroY': data.getFloat32(40, Endian.little),
        'gyroZ': data.getFloat32(44, Endian.little),
      };
    } else if (data.lengthInBytes == 24) {
      return {
        'timestamp': data.getUint16(0, Endian.little),
        'tipSensorValue': data.getInt16(2, Endian.little),
        'fingerSensorValue': data.getInt16(4, Endian.little),
        'angle': data.getInt16(6, Endian.little).abs(),
        'speed': data.getInt16(8, Endian.little),
        'batteryLevel': data.getInt16(10, Endian.little),
        'secondsInRange': data.getInt16(12, Endian.little),
        'secondsInUse': data.getInt16(14, Endian.little),
        'tipSensorUpperRange': data.getInt16(16, Endian.little),
        'tipSensorLowerRange': data.getInt16(18, Endian.little),
        'fingerSensorUpperRange': data.getInt16(20, Endian.little),
        'fingerSensorLowerRange': data.getInt16(22, Endian.little),
        'accX': 0,
        'accY': 0,
        'accZ': 0,
        'gyroX': 0,
        'gyroY': 0,
        'gyroZ': 0,
      };
    } else
      return {
        'timestamp': 0,
        'tipSensorValue': 0,
        'fingerSensorValue': 0,
        'angle': 0,
        'speed': 0,
        'batteryLevel': 0,
        'secondsInRange': 0,
        'secondsInUse': 0,
        'tipSensorUpperRange': 0,
        'tipSensorLowerRange': 0,
        'fingerSensorUpperRange': 0,
        'fingerSensorLowerRange': 0,
        'accX': 0,
        'accY': 0,
        'accZ': 0,
        'gyroX': 0,
        'gyroY': 0,
        'gyroZ': 0,
      };
  }
}
