import 'dart:typed_data';
import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';

class TriangleBlock extends BuildingBlock {
  Paint _paint;
  Path _path;
  bool _isTarget;
  Offset _p1;
  Offset _p2;
  Offset _p3;

  //this class is an Equilateral triangle
  TriangleBlock(Offset center, double halfBound, Color color, bool isTarget) {
    _p1 = Offset(center.dx, center.dy - halfBound);
    _p2 = Offset(center.dx + halfBound, center.dy + halfBound);
    _p3 = Offset(center.dx - halfBound, center.dy + halfBound);
    _path = Path();
    var _points = [_p1, _p2, _p3, _p1];
    _path.addPolygon(_points, true);
    _paint = Paint();
    _paint.style = PaintingStyle.fill;
    _paint.color = color;
    _isTarget = isTarget;
  }
    @override
  void drawOnCanvas(Canvas canvas) {
    canvas.drawPath(_path, _paint);
  }

  @override
  bool isClicked(Offset clickPosition) {
    bool isInYRange = clickPosition.dy >= _p1.dy && clickPosition.dy <= _p2.dy;
    bool isInXRange;
    Offset reflectedClickPosition;
    if(clickPosition.dx < _p1.dx) {
      reflectedClickPosition = Offset(_p1.dx + (_p1.dx - clickPosition.dx), clickPosition.dy);
    } else {
      reflectedClickPosition = clickPosition;
    }
    double m1 = (_p2.dy - _p1.dy) / (_p2.dx - _p1.dx);
    double m2 = reflectedClickPosition.dx == _p1.dx ? 1 : (reflectedClickPosition.dy - _p1.dy) / (reflectedClickPosition.dx - _p1.dx);
    isInXRange = m2 >= m1;
    return isInYRange && isInXRange;
  }

  @override
  bool isTarget() {
    return _isTarget;
  }

}