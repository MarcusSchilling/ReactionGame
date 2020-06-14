import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/bluetooth/finger_vibration.dart';
import 'package:reaction/game/board/board.dart';
import 'package:reaction/game/evaluator/evaluator.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/util/size_util.dart';

abstract class GameFactory {

  bool hasNext();

  void drawNext(Canvas canvas);

  void redraw(Canvas canvas);

  Hit hitTest(Offset position);

  bool shouldDrawNext();
  
  void closeGame();

  List<Evaluator> getEvaluators();

}

enum Hit {
  CORRECT, WRONG, NO_HIT
}

class ConcreteGameFactory extends GameFactory {

  int _numberOfRounds;
  Iterator<Board> _boards;
  Iterator<Evaluator> _evaluators;
  List<Evaluator> _evaluatorsList;
  FingerResponse _finger;

  ConcreteGameFactory(BuildingBoardFactory _boardFactory) {
    _numberOfRounds = _boardFactory.rounds;
    _boards = _boardFactory.boards.iterator;
    _evaluators = _boardFactory.evaluators.iterator;
    _evaluatorsList = _boardFactory.evaluators;
    _finger = GloveFingerResponse();
  }

  @override
  void drawNext(Canvas canvas) {
    --_numberOfRounds;
    //remember to keep & because the second part of the statement must be executed
    if(!_boards.moveNext() & !_evaluators.moveNext()) {
      throw new Exception("There is no more Board in this game");
    }
    _finger.notifyFinger(_boards.current.finger);
    var currentBoard = _boards.current;
    currentBoard.draw(canvas);
    //starts the time
    _evaluators.current.start();
    _drawResult(canvas);
  }

  @override
  void redraw(Canvas canvas) {
    _boards.current.draw(canvas);
    _finger.notifyFinger(_boards.current.finger);
    _drawResult(canvas);
  }

  void _drawResult(Canvas canvas) {
    var currentEvaluator = _evaluators.current;
    TextSpan span = new TextSpan(style: new TextStyle(color: Color.fromRGBO(100, 100, 100, 100)), text: currentEvaluator.result());
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset(SizeUtil.width/2, 5.0));
  }

  @override
  bool hasNext() {
    return  _numberOfRounds > 0 || (_evaluators.current != null && !_evaluators.current.finished());
  }

  Hit hitTest(Offset position) {
    var hit = _boards.current.isHit(position);
    _evaluators.current.hit(position);
    return hit;
  }

  @override
  List<Evaluator> getEvaluators() {
    return _evaluatorsList;
  }

  @override
  bool shouldDrawNext() {
    return (_evaluators.current == null && _numberOfRounds != 0) || _evaluators.current.finished();
  }

  @override
  void closeGame() {
    _finger.close();
  }

}