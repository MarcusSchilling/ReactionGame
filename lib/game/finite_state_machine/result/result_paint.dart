import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/evaluator/game_evaluator.dart';
import 'package:reaction/game/finite_state_machine/ui_elements/exit_button.dart';
import 'package:reaction/game/finite_state_machine/ui_elements/menu_button.dart';
import 'package:reaction/util/size_util.dart';

class ResultPaint extends CustomPainter {


  GameEvaluator _gameEvaluator;
  bool _goToMenu = false;
  CenteredButton menuButton = CenteredButton((SizeUtil.height / 2) + (SizeUtil.getAxisY(75)), "Menu");
  ExitButton _exitButton = ExitButton();

  ResultPaint(this._gameEvaluator);
  var _bigTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(50));
  var _middleTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(30));
  var _smallTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(20));


  get goToMenu => _goToMenu;

  @override
  void paint(Canvas canvas, Size size) {
    printHeading(canvas);
    paintScore(canvas);
    printTime(canvas);
    printFailures(canvas);
    menuButton.menuButton(canvas);
    _exitButton.exitButton(canvas);
  }

  @override
  bool hitTest(Offset position) {
    if(menuButton.hitTest(position)) {
      _goToMenu = true;
      return true;
    } else if (_exitButton.hitTest(position)) {
      exit(0);
      return true;
    }
    return false;
  }
  
  void printHeading(Canvas canvas) {
    TextSpan span = new TextSpan(style: _bigTextStyle, text: "Result");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    //Positioning in height by the golden ratio
    var startX = ((SizeUtil.width) / 2) - (tp.width / 2);
    var startY = SizeUtil.height * 0.2;
    tp.paint(canvas, new Offset(startX, startY));
  }

  void paintScore(Canvas canvas) {
    var score = _gameEvaluator.getScore().toString() + " Points";
    TextSpan scoreSpan = new TextSpan(style: _middleTextStyle, text: score);
    TextPainter scorePainter = new TextPainter(text: scoreSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    scorePainter.layout();
    var startX = (SizeUtil.width / 2) - (scorePainter.width / 2);
    var startY = SizeUtil.height / 2;
    scorePainter.paint(canvas, new Offset(startX, startY));
  }

  void printTime(Canvas canvas) {
    var timeItTook = "Time: " + _gameEvaluator.timeItTook().inSeconds.toString() + " Seconds" ;
    TextSpan timeTextSpan = new TextSpan(style: _smallTextStyle, text: timeItTook);
    TextPainter timePainter = new TextPainter(text: timeTextSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    timePainter.layout();
    var startX = (SizeUtil.width / 2) - (timePainter.width / 2);
    var startY = (SizeUtil.height / 2) + SizeUtil.getAxisY(25);
    timePainter.paint(canvas, Offset(startX, startY));
  }

  void printFailures(Canvas canvas) {
    var missAndFalse = "Failures: " + (_gameEvaluator.falseBuildingBlock() + _gameEvaluator.misses()).toString();
    TextSpan missAndFalseSpan = new TextSpan(style: _smallTextStyle, text: missAndFalse);
    TextPainter missAndFalsePainter = new TextPainter(text: missAndFalseSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    missAndFalsePainter.layout();
    var startX = (SizeUtil.width / 2) - (missAndFalsePainter.width/2);
    var startY = (SizeUtil.height / 2) + (SizeUtil.getAxisY(45));
    missAndFalsePainter.paint(canvas, new Offset(startX, startY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}