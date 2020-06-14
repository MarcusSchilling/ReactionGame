
import 'dart:ui';

import 'package:reaction/game/evaluator/evaluator.dart';
import 'package:reaction/game/evaluator/game_evaluator.dart';
import 'package:test_api/test_api.dart';

main() {
  test('test Game Evaluator', (){
    List<Evaluator> evaluators = List();
    evaluators.add(MockEvaluator(1, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 1, Duration(seconds: 0)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 0)));
    ConcreteGameEvaluator concreteGameEvaluator = ConcreteGameEvaluator(evaluators);
    expect(concreteGameEvaluator.timeItTook(), Duration(seconds: 3));
    expect(concreteGameEvaluator.misses(), 1);
    expect(concreteGameEvaluator.falseBuildingBlock(), 1);
    expect(concreteGameEvaluator.getScore(), 48);
  });
  test('time abgelaufen', () {
    List<Evaluator> evaluators = List();
    evaluators.add(MockEvaluator(1, 1, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 1, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 1, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(1, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 1, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    evaluators.add(MockEvaluator(0, 0, Duration(seconds: 1)));
    ConcreteGameEvaluator concreteGameEvaluator = ConcreteGameEvaluator(evaluators);
    expect(concreteGameEvaluator.timeItTook(), Duration(seconds: 20));
    expect(concreteGameEvaluator.misses(), 4);
    expect(concreteGameEvaluator.falseBuildingBlock(), 2);
    expect(concreteGameEvaluator.getScore(), 44);
  });
}

class MockEvaluator extends Evaluator {

  int _falseBuildingBlock;
  int _miss;
  Duration _timeDone;


  MockEvaluator(this._falseBuildingBlock, this._miss, this._timeDone);

  @override
  int falseBuildingBlock() {
    return _falseBuildingBlock;
  }

  @override
  bool finished() {
    return true;
  }

  @override
  void hit(Offset position) {
    return;
  }

  @override
  int miss() {
    return _miss;
  }

  @override
  String result() {
    // TODO: implement result
    return null;
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Duration timeDone() {
    return _timeDone;
  }

}