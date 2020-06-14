import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/evaluator/evaluator.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/menu/menu_state.dart';
import 'package:reaction/game/finite_state_machine/result/result_screen.dart';


class Game {
  GameState _currentState;

  Game(int rounds) {
    _currentState = MenuState();
  }

  void changeState(GameState newState) {
    _currentState = newState;
  }

  Widget currentWidget(State state) {
    return _currentState.currentWidget(state, this);
  }
  
  void closeApplication() {
    _currentState.onExit();
  }

}