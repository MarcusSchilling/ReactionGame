import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/finite_state_machine/ui_elements/exit_button.dart';
import 'package:reaction/util/size_util.dart';

class NoConnectionPainter extends CustomPainter{

  var _bigTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(50));
  var _middleTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(30));
  var _smallTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(20));
  var _exitButton = new ExitButton();


  @override
  void paint(Canvas canvas, Size size) {
    printHeading(canvas);
    printError(canvas);
    _exitButton.exitButton(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void printHeading(Canvas canvas) {
    TextSpan span = new TextSpan(style: _middleTextStyle, text: "Connection Problems");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    //Positioning in height by the golden ratio
    var startX = ((SizeUtil.width) / 2) - (tp.width / 2);
    var startY = SizeUtil.height * 0.2;
    tp.paint(canvas, new Offset(startX, startY));
  }

  void printError(Canvas canvas) {
    var score = " Please make sure that your device \n supports Bluetooth LE. \n Make sure that Bluetooth is turned on. \n Make sure the glove \n is powered and turned on. \n";
    TextSpan scoreSpan = new TextSpan(style: _smallTextStyle, text: score);
    TextPainter scorePainter = new TextPainter(text: scoreSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    scorePainter.layout();
    var startX = (SizeUtil.width / 2) - (scorePainter.width / 2);
    var startY = SizeUtil.height / 2;
    scorePainter.paint(canvas, new Offset(startX, startY));
  }

  @override
  bool hitTest(Offset position) {
    if(_exitButton.hitTest(position)) {
      exit(0);
      return true;
    }
    return false;
  }

}