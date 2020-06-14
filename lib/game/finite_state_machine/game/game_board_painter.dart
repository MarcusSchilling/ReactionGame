import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/factories/game_factory.dart';

class GameBoardPainter extends CustomPainter {

  GameFactory _concreteGameFactory;
  bool _repaint = true;

  GameBoardPainter(this._concreteGameFactory);

  @override
  void paint(Canvas canvas, Size size) {
    if(_concreteGameFactory.shouldDrawNext()) {
      _concreteGameFactory.drawNext(canvas);
    } else {
      _concreteGameFactory.redraw(canvas);
    }
  }

  @override
  bool hitTest(Offset position) {
    if (_concreteGameFactory.hitTest(position) == Hit.CORRECT) {
      _repaint = true;
      return true;
    } else {
      _repaint = false;
      return true;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this._repaint;
  }

}