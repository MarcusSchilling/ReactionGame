import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reaction/game/bluetooth/bluetooth_handler.dart';
import 'package:reaction/game/bluetooth/finger_vibration.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/game.dart';
import 'package:reaction/game/finite_state_machine/game/game_state.dart';
import 'package:reaction/game/finite_state_machine/menu/menu_painter.dart';
import 'package:reaction/game/finite_state_machine/no_connection_state/no_connection_state.dart';
import 'package:reaction/game_page.dart';
import 'package:reaction/util/size_util.dart';

class MenuState extends GameState<State<MyHomePage>> {

  MenuPainter _paint;


  MenuState() {
    _paint = MenuPainter();
  }

  @override
  Widget currentWidget(State state, Game game) {
    BluetoothHandler bluetoothHandler = BluetoothHandler.singleton();
    int rounds = 5;
    int numberOfColumns = 3;
    int numberOfFieldsPerBoard = 4;
    int numberOfLines = 5;
    bluetoothHandler.onDisconnected = (() {
      game.changeState(NoConnectionState(this));
      return game.currentWidget(state);
    });

    BuildingBoardFactory _buildingBoardFactory;
    if(_paint.hit == GameModes.COLOR_FINGER) {
      _buildingBoardFactory = ColorFingerEqualShape(numberOfFieldsPerBoard, numberOfColumns, numberOfLines, rounds);
    } else if (_paint.hit == GameModes.SHAPE) {
      _buildingBoardFactory = ColorShapeFactory(numberOfFieldsPerBoard, numberOfColumns, numberOfLines, rounds);
    }
    if(_buildingBoardFactory != null) {
      if(!bluetoothHandler.connected()) {
        game.changeState(NoConnectionState(this));
        return game.currentWidget(state);
      } else {
        game.changeState(InGameState(_buildingBoardFactory));
        return game.currentWidget(state);
      }
    }

    return Scaffold(
        body: GestureDetector(
          child: SizedBox(
            width: SizeUtil.width,
            height: SizeUtil.height,
            child: CustomPaint(
                painter: _paint
            ),
          ),
          onPanEnd: (details) {
            //game.changeState(MenuState());
            state.setState(() {});
          },
        )
    );
  }

}
