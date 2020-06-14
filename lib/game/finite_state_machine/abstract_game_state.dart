import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/bluetooth/bluetooth_handler.dart';
import 'package:reaction/game/bluetooth/finger_vibration.dart';
import 'package:reaction/game/finite_state_machine/game.dart';

abstract class GameState<A extends State> {

  Widget currentWidget(A state, Game game);

  void onExit() {
    BluetoothHandler.singleton().disconnect();
  }

}