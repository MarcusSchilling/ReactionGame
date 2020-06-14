import 'dart:core';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:reaction/game/board/building_block/building_block.dart';
import 'package:reaction/game/board/building_block/circle_block.dart';
import 'package:reaction/game/board/board.dart';
import 'package:reaction/game/board/building_block/cross_block.dart';
import 'package:reaction/game/board/building_block/square.dart';
import 'package:reaction/game/board/building_block/triangle_block.dart';
import 'package:reaction/game/evaluator/evaluator.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/factories/finger_factory.dart';
import 'package:reaction/game/factories/position_factory.dart';
import 'package:reaction/util/size_util.dart';

enum GameModes {
  COLOR_FINGER, SHAPE
}

abstract class BuildingBoardFactory {
  
  PositionFactory _positionFactory;
  ColorFactory _colorFactory;
  List<Board> _boards = List();
  List<Evaluator> _evaluators = List();
  int _rounds;
  FingerFactory _fingerFactory;

  BuildingBoardFactory(this._positionFactory, this._colorFactory, this._rounds, {FingerFactory fingerFactory}) {
    _fingerFactory =  fingerFactory == null ? RandomFingerFactory() : fingerFactory;
  }

  List<Board> get boards => _boards;

  List<Evaluator> get evaluators => _evaluators;

  int get rounds => _rounds;
  
  ///the default finger factory is a RandomFingerFactory you can specify one in the constructor
  List<Finger> randomFingers() {
    return _fingerFactory.getFingers(rounds);
  }

}

class ColorFingerEqualShape extends BuildingBoardFactory {

  
  ColorFingerEqualShape(int numberOfFieldsPerBoard, int numberOfColumns, int numberOfLines, int rounds)
      : super(PositionFactory(numberOfFieldsPerBoard, numberOfColumns, numberOfLines, rounds), RandomColorFactory(), rounds) {
    var targetFingers = randomFingers();
    for(int round = 0; round < rounds; round++) {
      Board board = Board();
      for(int i = 0; i < numberOfFieldsPerBoard; i++) {
        board.addBlock(CircleBlock(_positionFactory.getPhysicalCenterPosition(round,i), SizeUtil.getRadius(),
            _colorFactory.getColor(i), _colorFactory.getColorOfFinger(i) == targetFingers.elementAt(round)));
        board.addTargetFinger(targetFingers.elementAt(round));
      }
      _boards.add(board);
      _evaluators.add(new ConcreteEvaluator(board));
    }
  }
  
  
}

class ColorShapeFactory extends BuildingBoardFactory {
  ColorShapeFactory(int numberOfFieldsPerBoard, int numberOfColumns, int numberOfLines, int rounds) 
      : super(PositionFactory(numberOfFieldsPerBoard, numberOfColumns, numberOfLines, rounds), RandomEqualColorFactory(), rounds) {
    var targetFingers = randomFingers();
    for(int round = 0; round < rounds; round++) {
      Board board = Board();
      var circle = Finger.RING_FINGER == targetFingers.elementAt(round);
      board.addBlock(CircleBlock(_positionFactory.getPhysicalCenterPosition(round,0), SizeUtil.getRadius(),
          _colorFactory.getColor(0), circle));
      var square = Finger.MIDDLE_FINGER == targetFingers.elementAt(round);
      board.addBlock(SquareBlock(_positionFactory.getPhysicalCenterPosition(round,1), SizeUtil.getRadius(),
          _colorFactory.getColor(1), square));
      var triangle = Finger.INDEX_FINGER == targetFingers.elementAt(round);
      board.addBlock(TriangleBlock(_positionFactory.getPhysicalCenterPosition(round, 2),
          SizeUtil.getRadius(),
          _colorFactory.getColor(2), triangle));
      var cross =  Finger.BABY_FINGER == targetFingers.elementAt(round);
      board.addBlock(CrossBlock(_positionFactory.getPhysicalCenterPosition(round, 3), SizeUtil.getRadius(),
      _colorFactory.getColor(3), cross));
          board.addTargetFinger(targetFingers.elementAt(round));
      _boards.add(board);
      _evaluators.add(new ConcreteEvaluator(board));
    }
  }
  
}