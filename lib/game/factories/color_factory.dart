import 'dart:math';
import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';
import 'package:reaction/util/method_not_supported.dart';

enum Finger {
  INDEX_FINGER, MIDDLE_FINGER, RING_FINGER, BABY_FINGER, THUMB //the thumb is not use to indicate a color
}

abstract class ColorFactory {

  List<Color> _usedColors = List();
  Map<Color, Finger> _fingers = Map();

  ColorFactory() {
    //here you could use settings for colour-blind people for example
    _usedColors.add(Color.fromRGBO(100, 100, 100, 100));
    _fingers.putIfAbsent(_usedColors.elementAt(0), () => Finger.INDEX_FINGER);
    _usedColors.add(Color.fromRGBO(200, 100, 100, 100));
    _fingers.putIfAbsent(_usedColors.elementAt(1), () => Finger.MIDDLE_FINGER);
    _usedColors.add(Color.fromRGBO(200, 0, 100, 100));
    _fingers.putIfAbsent(_usedColors.elementAt(2), () => Finger.RING_FINGER);
    _usedColors.add(Color.fromRGBO(0, 200, 200, 100));
    _fingers.putIfAbsent(_usedColors.elementAt(3), () => Finger.BABY_FINGER);
  }

  Color getColor(int index);

  Finger getColorOfFinger(int index);

  static Color getButtonColor() {
    return Color.fromRGBO(100, 100, 100, 60);
  }

}


class EqualColorFactory extends ColorFactory{

  @override
  Color getColor(int index) {
    return _usedColors.elementAt(0);
  }

  @override
  Finger getColorOfFinger(int index) {
    throw new MethodNotSupportedException();
  }

}

class RandomEqualColorFactory extends ColorFactory {
  int _colorIndex;


  RandomEqualColorFactory(){
    Random random;
    try{
      random = Random.secure();
    }catch(e) {
      random = Random();
    }
    _colorIndex = random.nextInt(_usedColors.length);
  }

  @override
  Color getColor(int index) {
    return _usedColors.elementAt(_colorIndex);
  }

  @override
  Finger getColorOfFinger(int index) {
    // TODO: implement getColorOfFinger
    return null;
  }

}

class RandomColorFactory extends ColorFactory{

  @override
  Color getColor(int index) {
    return _usedColors.elementAt(index);
  }

  @override
  Finger getColorOfFinger(int index) {
    return _fingers[_usedColors.elementAt(index)];
  }

}

class ShapeColorFactory extends ColorFactory{
  
  List<Shape> shapesOfElements;

  ShapeColorFactory(List<Shape> shapesOfElements) {
    this.shapesOfElements = shapesOfElements;
  }

  @override
  Color getColor(int index) {
    return _usedColors.elementAt(shapesOfElements.elementAt(index).index);
  }

  @override
  Finger getColorOfFinger(int index) {
    throw new MethodNotSupportedException();
  }
}