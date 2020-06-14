import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';

class CrossBlock extends BuildingBlock {
  
  Rect _first;
  Rect _second;
  Path _path;
  Color _color;
  bool _isTarget;

  CrossBlock(Offset center, double halfBound, this._color, this._isTarget) {
    _first = Rect.fromLTRB(center.dx - halfBound, center.dy - (halfBound / 2), center.dx + halfBound, center.dy + (halfBound / 2));
    _second = Rect.fromLTRB(center.dx - (halfBound / 2), center.dy - (halfBound), center.dx + (halfBound / 2), center.dy + halfBound);
    _path = Path();
    var x1 = center.dx - halfBound;
    var x2 = center.dx - (halfBound / 2);
    var x3 = center.dx + (halfBound / 2);
    var x4 = center.dx + halfBound;
    var y1 = center.dy - halfBound;
    var y2 = center.dy - (halfBound / 2);
    var y3 = center.dy + (halfBound / 2);
    var y4 = center.dy + halfBound;
    List<Offset> points = [Offset(x1, y3), Offset(x2, y3), Offset(x2, y4), Offset(x3, y4), Offset(x3,y3), Offset(x4, y3),
                           Offset(x4,y2), Offset(x3, y2), Offset(x3, y1), Offset(x2, y1), Offset(x2, y2), Offset(x1,y2), Offset(x1, y3)];
    _path.addPolygon(points, true);
  }


  @override
  void drawOnCanvas(Canvas canvas) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = _color;
    canvas.drawPath(_path, paint);
  }

  @override
  bool isClicked(Offset clickPosition) {
    return _contains(_first, clickPosition) || _contains(_second, clickPosition);
  }
  
  bool _contains(Rect _square, Offset clickPosition) {
    return (_square.left <= clickPosition.dx && _square.right >= clickPosition.dx)
        && (_square.bottom >= clickPosition.dy && _square.top <= clickPosition.dy);
  }

  @override
  bool isTarget() {
    return _isTarget;
  }
  
}