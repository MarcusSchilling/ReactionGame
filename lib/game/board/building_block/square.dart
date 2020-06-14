import 'dart:math';
import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';

class SquareBlock extends BuildingBlock {

  Rect _square;
  Color _color;
  bool _isTarget;


  SquareBlock(Offset center, double halfBound, this._color, this._isTarget) {
    _square = Rect.fromLTRB(center.dx - halfBound, center.dy + halfBound, center.dx + halfBound, center.dy - halfBound);
  }

  @override
  void drawOnCanvas(Canvas canvas) {
    Paint paint = Paint();
    paint.color = _color;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(_square, paint);
  }

  @override
  bool isClicked(Offset clickPosition) {
    return (_square.left <= clickPosition.dx && _square.right >= clickPosition.dx)
            && (_square.bottom <= clickPosition.dy && _square.top >= clickPosition.dy);
  }

  @override
  bool isTarget() {
    return _isTarget;
  }

}