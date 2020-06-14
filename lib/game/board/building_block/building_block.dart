import 'dart:ui';

enum Shape {
  CIRCLE, SQUARE
}

abstract class BuildingBlock {

  void drawOnCanvas(Canvas canvas);

  bool isClicked(Offset clickPosition);

  bool isTarget();

  // needs to ensure that == is implemented to secure that there are no two duplicates on a board
  bool operator ==(Object other);

  int get hashCode;



}