import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:reaction/game/bluetooth/bluetooth_handler.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/game.dart';
import 'package:reaction/game/finite_state_machine/no_connection_state/no_connection_painter.dart';
import 'package:reaction/game_page.dart';
import 'package:reaction/util/size_util.dart';

class NoConnectionState extends GameState<State<MyHomePage>> {
  GameState _lastState;
  BluetoothHandler _bluetoothHandler;
  NoConnectionPainter _noConnectionPainter;

  NoConnectionState(this._lastState) {
    _noConnectionPainter = NoConnectionPainter();
    _bluetoothHandler = BluetoothHandler.singleton();
  }

  @override
  Widget currentWidget(State<MyHomePage> state, Game game) {
    _bluetoothHandler.scan();
    _bluetoothHandler.onData = (() {
      game.changeState(_lastState);
      state.setState(() {});
      _bluetoothHandler.onDisconnected = () {
        game.changeState(this);
        state.setState(() {});
      };
    });
    return Scaffold(
        body: GestureDetector(
          child: SizedBox(
            width: SizeUtil.width,
            height: SizeUtil.height,
            child: CustomPaint(
                painter: _noConnectionPainter
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
