import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:reaction/util/size_util.dart';
import 'package:vibrate/vibrate.dart';

class CenteredButton {
  TextStyle _middleTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(30));

  Rect _rect;
  String _text;
  
  CenteredButton(double physicalTopPosition, this._text) {
    _rect = Rect.fromLTRB(SizeUtil.getAxisX(500 * 1/4),
        physicalTopPosition,
        SizeUtil.getAxisX(500 * 3/4),
        physicalTopPosition + SizeUtil.getAxisY(45));
  }
  
  
  void menuButton(Canvas canvas) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = SizeUtil.getAxisBoth(4);
    paint.color = Color.fromRGBO(100, 100, 100, 100);
    TextSpan span = new TextSpan(style: _middleTextStyle, text: _text);
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    //Positioning in height by the golden ratio
    var textX = ((SizeUtil.width) / 2) - (tp.width / 2);
    var textY = _rect.top + SizeUtil.getAxisY(10);
    tp.paint(canvas, new Offset(textX, textY));
    canvas.drawRect(_rect, paint);
  }

  bool hitTest(Offset position) {
    if(_rect.contains(position)) {
      Vibrate.feedback(FeedbackType.success);
      return true;
    }
    return false;
  }

}