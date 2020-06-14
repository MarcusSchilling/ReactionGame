import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reaction/game/bluetooth/finger_vibration.dart';
import 'package:reaction/game/evaluator/evaluator.dart';
import 'package:reaction/game/evaluator/game_evaluator.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/game.dart';
import 'package:reaction/game/finite_state_machine/menu/menu_state.dart';
import 'package:reaction/game/finite_state_machine/result/result_paint.dart';
import 'package:reaction/game_page.dart';
import 'package:reaction/util/size_util.dart';

class ResultState extends GameState<State<MyHomePage>>{


  GameEvaluator _gameEvaluator;
  ResultPaint _resultPaint;

  ResultState(List<Evaluator> evaluators) {
    _gameEvaluator = ConcreteGameEvaluator(evaluators);
    _resultPaint = ResultPaint(_gameEvaluator);
  }

  @override
  Widget currentWidget(State state, Game game) {
    if(_resultPaint.goToMenu) {
      game.changeState(MenuState());
      return game.currentWidget(state);
    }
    return Scaffold(
        body: GestureDetector(
          child: SizedBox(
            width: SizeUtil.width,
            height: SizeUtil.height,
            child: CustomPaint(
                painter: _resultPaint
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