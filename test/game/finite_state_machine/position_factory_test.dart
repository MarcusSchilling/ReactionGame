import 'package:reaction/game/factories/position_factory.dart';
import 'package:test_api/test_api.dart';

main() {
  test('Creates Random Positions', () {
    PositionFactory positionFactory = PositionFactory(5, 4, 4, 1);
    for(int i= 0; i < 5; i++) {
      for(int j = 0; j < 5; j++) {
        if (i == j) continue;
        expect(positionFactory.getLogicCenterPosition(0,i) != positionFactory.getLogicCenterPosition(0,j), true);
      }
    }
  });

  test('test equals from coordinates', () {
    Coordinate coordinate = Coordinate(10, 10);
    Coordinate coordinateTwo = Coordinate(11, 10);
    expect(coordinate == coordinate, true);
    expect(coordinate == coordinateTwo, false);
  });
  test('test two rounds', () {
    int rounds = 2;
    PositionFactory positionFactory = PositionFactory(5, 4, 4, rounds);
    for(int roundIndex = 0; roundIndex <rounds; roundIndex++) {
      for(int i= 0; i < 5; i++) {
        for(int j = 0; j < 5; j++) {
          if (i == j) continue;
          expect(positionFactory.getLogicCenterPosition(roundIndex,i) != positionFactory.getLogicCenterPosition(roundIndex,j), true);
        }
      }
    }
  });
}