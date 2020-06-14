import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reaction/game/bluetooth/bluetooth_handler.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/game/factories/game_factory.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/game.dart';
import 'package:reaction/game/finite_state_machine/game/game_board_painter.dart';
import 'package:reaction/game/finite_state_machine/no_connection_state/no_connection_state.dart';
import 'package:reaction/game/finite_state_machine/result/result_screen.dart';
import 'package:reaction/game_page.dart';
import 'package:reaction/util/size_util.dart';

class InGameState extends GameState<State<MyHomePage>>{

  ConcreteGameFactory _concreteGameFactory;

  InGameState(BuildingBoardFactory boardFactory) {
    _concreteGameFactory = ConcreteGameFactory(boardFactory);
  }

  @override
  Widget currentWidget(State state, Game game) {
    if(!_concreteGameFactory.hasNext()) {
      _concreteGameFactory.closeGame();
      game.changeState(ResultState(_concreteGameFactory.getEvaluators()));
      return game.currentWidget(state);
    }
    BluetoothHandler _bluetoothHandler = BluetoothHandler.singleton();
    _bluetoothHandler.onDisconnected = (() {
      game.changeState(NoConnectionState(this));
      state.setState(() {});
    });
    GameBoardPainter openPainter = GameBoardPainter(_concreteGameFactory);
    return Scaffold(
        body: GestureDetector(
          child: Center(
            child: SizedBox(
              width: SizeUtil.width,
              height: SizeUtil.height,
              child: CustomPaint(
                  painter: openPainter
              ),
            ),
          ),
          onPanEnd: (details) {
            state.setState(() {});
            },
        )
    );
  }

}