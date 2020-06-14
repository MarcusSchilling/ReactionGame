import 'dart:math';

import 'package:reaction/game/factories/color_factory.dart';

abstract class FingerFactory {

  List<Finger> getFingers(int number);
}


class RandomFingerFactory extends FingerFactory{

  Random random;

  RandomFingerFactory() {
    try {
      random = Random.secure();
    } catch (error) {
      //the secure() method can throw an unsupported error if the device cannot provide a crypto. secure random generator
      random = Random();
    }
  }

  @override
  List<Finger> getFingers(int number) {
    return List.generate(number, (index) => Finger.values[random.nextInt(Finger.values.length - 1)]);
  }

}