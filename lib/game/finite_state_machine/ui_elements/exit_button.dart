import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:reaction/util/size_util.dart';
import 'package:vibrate/vibrate.dart';

class ExitButton {
  TextStyle _middleTextStyle = new TextStyle(color: Color.fromRGBO(100, 100, 100, 100), fontSize: SizeUtil.getAxisBoth(30));

  Rect _rect;
  String _text = "X";

  ExitButton() {
    _rect = Rect.fromLTRB(SizeUtil.getAxisBoth(20),
        SizeUtil.getAxisBoth(20),
        SizeUtil.getAxisBoth(60),
        SizeUtil.getAxisBoth(60));
  }

  void exitButton(Canvas canvas) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = SizeUtil.getAxisBoth(4);
    paint.color = Color.fromRGBO(100, 100, 100, 100);
    TextSpan span = new TextSpan(style: _middleTextStyle, text: _text);
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    //Positioning in height by the golden ratio
    var textX = _rect.left + ((_rect.width) / 2) - SizeUtil.getAxisX(13);
    var textY = _rect.top + SizeUtil.getAxisY(3);
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