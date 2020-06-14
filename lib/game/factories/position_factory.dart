import 'dart:math';
import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';
import 'package:reaction/util/size_util.dart';

class PositionFactory {

  List<Set<Coordinate>> _positions = List();
  int _numberOfColumns;
  int _numberOfLines;
  int _numberOfRounds;

  int _numberOfFieldsPerBoard;


  PositionFactory(this._numberOfFieldsPerBoard, this._numberOfColumns, this._numberOfLines, this._numberOfRounds) {
    assert(_numberOfFieldsPerBoard < _numberOfColumns * _numberOfLines);
    _calculatePositions();
  }

  void _calculatePositions() {
    for (int i = 0; i < _numberOfRounds; i++) {
      var random = Random.secure();
      Set<Coordinate> _currentPositions = Set();
      while (_numberOfFieldsPerBoard > _currentPositions.length) {
        var columnNum = random.nextInt(_numberOfColumns);
        var lineNum = random.nextInt(_numberOfLines);
        var coordinate = Coordinate(columnNum, lineNum);
        _currentPositions.add(coordinate);
      }
      _positions.add(_currentPositions);
      assert(_currentPositions.length == _numberOfFieldsPerBoard);
    }
    assert(_positions.length == _numberOfRounds);
    
  }
  
  Coordinate getLogicCenterPosition(int round, int index) {
    return _positions.elementAt(round).elementAt(index);
  }

  Offset getPhysicalCenterPosition(int round, int index) {
    Coordinate logicalCenterPosition = getLogicCenterPosition(round, index);
    double marginX = SizeUtil.getAxisX(100);
    double marginY = SizeUtil.getAxisY(50);
    var marginXBetweenElements = SizeUtil.getAxisX((500 - marginX) / _numberOfColumns);
    var marginYBetweenElements = SizeUtil.getAxisY(500 / _numberOfLines);
    double x = marginX + ((logicalCenterPosition._x) * marginXBetweenElements);
    double y = marginY + ((logicalCenterPosition._y) * marginYBetweenElements);
    return Offset(x,y);
  }
}
class Coordinate {
  int _x;
  int _y;

  Coordinate(this._x, this._y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Coordinate &&
              runtimeType == other.runtimeType &&
              _x == other._x &&
              _y == other._y;

  @override
  int get hashCode =>
      _x.hashCode ^
      _y.hashCode;

}