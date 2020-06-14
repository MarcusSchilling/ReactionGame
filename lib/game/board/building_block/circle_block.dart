import 'dart:math';
import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';

class CircleBlock extends BuildingBlock {
  var _radius;
  var _circleCenter;
  var _color;
  var _isTarget;

  // radius in
  CircleBlock(this._circleCenter, this._radius, this._color, this._isTarget);

  @override
  void drawOnCanvas(Canvas canvas) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;
    paint.color = _color;
    canvas.drawCircle(_circleCenter, _radius, paint);
  }

  @override
  bool isClicked(Offset clickPosition) {
    var positionXCircle = _circleCenter.dx;
    var positionYCircle = _circleCenter.dy;
    var positionXClick = clickPosition.dx;
    var positionYClick = clickPosition.dy;
    var a2 = pow((positionXCircle - positionXClick).abs(), 2);
    var b2 = pow((positionYCircle- positionYClick).abs(),2);
    var c = sqrt(a2 + b2);
    return c <= _radius;
  }

  @override
  bool isTarget() {
    return _isTarget;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CircleBlock &&
              runtimeType == other.runtimeType &&
              _radius == other._radius &&
              _circleCenter == other._circleCenter;

  @override
  int get hashCode =>
      _radius.hashCode ^
      _circleCenter.hashCode;




}
