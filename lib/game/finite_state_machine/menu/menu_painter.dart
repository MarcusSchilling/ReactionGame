import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/game/finite_state_machine/ui_elements/exit_button.dart';
import 'package:reaction/game/finite_state_machine/ui_elements/menu_button.dart';
import 'package:reaction/util/size_util.dart';

class MenuPainter extends CustomPainter {

  CenteredButton _colorMode;
  CenteredButton _shapeMode;
  ExitButton _exitButton;

  GameModes _hit;
  var _bigTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(50));

  MenuPainter() {
    _colorMode = CenteredButton(SizeUtil.getAxisY(500 /3), "Color Mode");
    _shapeMode = CenteredButton(SizeUtil.getAxisY((500 * 2) / 3), "Shape Mode");
    _exitButton = ExitButton();
  }

  GameModes get hit => _hit;

  @override
  void paint(Canvas canvas, Size size) {
    printHeading(canvas);
    _colorMode.menuButton(canvas);
    _shapeMode.menuButton(canvas);
    _exitButton.exitButton(canvas);
  }

  void printHeading(Canvas canvas) {
    TextSpan span = new TextSpan(style: _bigTextStyle, text: "Menu");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    //Positioning in height by the golden ratio
    var startX = ((SizeUtil.width) / 2) - (tp.width / 2);
    var startY = SizeUtil.height * 0.2;
    tp.paint(canvas, new Offset(startX, startY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    if (_colorMode.hitTest(position)) {
      _hit = GameModes.COLOR_FINGER;
      return true;
    } else if(_shapeMode.hitTest(position)) {
      _hit = GameModes.SHAPE;
      return true;
    } else if(_exitButton.hitTest(position)) {
      exit(0);
      return true;
    }
  }

}