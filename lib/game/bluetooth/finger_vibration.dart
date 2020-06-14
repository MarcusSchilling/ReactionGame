import 'dart:async';

import 'package:reaction/game/bluetooth/bluetooth_handler.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:reaction/util/device_not_found.dart';
import 'package:reaction/util/method_not_supported.dart';

abstract class FingerResponse {

  void notifyFinger(Finger finger);

  void close();

}

class GloveFingerResponse extends FingerResponse {

  BluetoothHandler _bluetoothHandler = BluetoothHandler.singleton();

  @override
  Future notifyFinger(Finger finger) async {
    vibrateFinger(finger: finger);
    print(finger.toString());
  }

  @override
  void close() {
    vibrateFinger();
  }


  /// if no finger is passed no finger will vibrate
  void vibrateFinger({Finger finger}) async {
    await _bluetoothHandler.writeCharacteristic(finger);
  }
}