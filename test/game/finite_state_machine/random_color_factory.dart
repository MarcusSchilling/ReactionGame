import 'package:reaction/game/factories/color_factory.dart';
import 'package:test_api/test_api.dart';

main() {
  test('getColors', () {
    RandomColorFactory randomColorFactory = RandomColorFactory();
    expect(randomColorFactory.getColorOfFinger(0) == Finger.INDEX_FINGER, true);
    expect(randomColorFactory.getColorOfFinger(1) == Finger.MIDDLE_FINGER, true);
    expect(randomColorFactory.getColorOfFinger(2) == Finger.RING_FINGER, true);
    expect(randomColorFactory.getColorOfFinger(3) == Finger.BABY_FINGER, true);
  });
}