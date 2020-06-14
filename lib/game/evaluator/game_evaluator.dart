import 'dart:math';

import 'package:reaction/game/evaluator/evaluator.dart';

abstract class GameEvaluator {

  int getScore();

  Duration timeItTook();

  int misses();

  int falseBuildingBlock();
}

class ConcreteGameEvaluator extends GameEvaluator{

  List<Evaluator> _evaluators;

  ConcreteGameEvaluator(this._evaluators);

  @override
  int getScore() {
    var calculatedTimeWithFails = (timeItTook().inMilliseconds + (((falseBuildingBlock() + misses()) * 3000)));
    double averageTimePerBlockInMilliseconds = calculatedTimeWithFails / _evaluators.length;
    var timePart = 120 - (0.04 * averageTimePerBlockInMilliseconds);
    return timePart.toInt();
  }

  @override
  int misses() {
    return _evaluators.fold(0, (previous, current) => previous + current.miss());
  }

  @override
  Duration timeItTook() {
    return _evaluators.fold(Duration(), (combinedDuration, evaluator) => combinedDuration + evaluator.timeDone());
  }

  @override
  int falseBuildingBlock() {
    return _evaluators.fold(0, (previous, current) => previous + current.falseBuildingBlock());
  }


}