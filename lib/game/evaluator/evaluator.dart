import 'dart:ui';

import 'package:reaction/game/board/board.dart';
import 'package:reaction/game/board/building_block/building_block.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/factories/game_factory.dart';
import 'package:reaction/util/method_not_supported.dart';


abstract class Evaluator {

  void start();

  void hit(Offset position);

  Duration timeDone();

  String result();

  int miss();

  int falseBuildingBlock();

  bool finished();

}

class ConcreteEvaluator extends Evaluator {

  DateTime _startTime;
  DateTime _endTime;
  int _falseBuildingBlock = 0;
  int _miss = 0;
  Board _board;
  List<Offset> _taps = List();

  ConcreteEvaluator(this._board);

  @override
  void start() {
    _startTime = DateTime.now();
  }


  @override
  void hit(Offset position) {
    _taps.add(position);
    if(_board.isHit(position) == Hit.NO_HIT) {
      _miss++;
    } else {
      BuildingBlock hitPosition = _board.hitPosition(position);
      if(hitPosition.isTarget() == false) {
        _falseBuildingBlock++;
      } else {
        _endTime = DateTime.now();
      }
    }
  }

  @override
  Duration timeDone() {
    if(_endTime == null) {
      throw new MethodNotSupportedException();
    }
    return _endTime.difference(_startTime);
  }

  @override
  String result() {
    return "Miss: " + _miss.toString() + " False: " + _falseBuildingBlock.toString();
  }

  @override
  bool finished() {
    return _taps.any((position) => _board.isHit(position) == Hit.CORRECT);
  }

  @override
  int falseBuildingBlock() {
    return _falseBuildingBlock;
  }

  @override
  int miss() {
    return _miss;
  }

}
