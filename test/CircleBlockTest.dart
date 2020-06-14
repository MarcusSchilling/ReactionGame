import 'dart:ui';

import 'package:reaction/game/board/building_block/circle_block.dart';
import 'package:test_api/test_api.dart';

void main() {
  CircleBlock circleBlock;
  test('Test click inside circle Block', () {
    circleBlock = CircleBlock(Offset(100, 100), 50.0, Color.fromRGBO(100, 100, 100, 100), true);
    //Mittelpunkt
    expect(circleBlock.isClicked(Offset(100,100)), true);

    //Quadrants are seen as x=y=0 is on the top left corner in this. And max is Right bottom corner.

    //4.Quadrant
    expect(circleBlock.isClicked(Offset(100,150)), true);
    expect(circleBlock.isClicked(Offset(100,151)), false);
    expect(circleBlock.isClicked(Offset(150,100)), true);
    expect(circleBlock.isClicked(Offset(151,100)), false);
    expect(circleBlock.isClicked(Offset(135,135)), true);
    expect(circleBlock.isClicked(Offset(136,136)), false);
    expect(circleBlock.isClicked(Offset(136,135)), false);
    expect(circleBlock.isClicked(Offset(126,125)), true);

    //1.Quadrant
    expect(circleBlock.isClicked(Offset(135,65)), true);
    expect(circleBlock.isClicked(Offset(136,64)), false);
    expect(circleBlock.isClicked(Offset(136,65)), false);
    expect(circleBlock.isClicked(Offset(126,75)), true);

    //3.Quadrant
    expect(circleBlock.isClicked(Offset(50,100)), true);
    expect(circleBlock.isClicked(Offset(49,100)), false);
    expect(circleBlock.isClicked(Offset(65,135)), true);
    expect(circleBlock.isClicked(Offset(64,136)), false);
    expect(circleBlock.isClicked(Offset(64,135)), false);
    expect(circleBlock.isClicked(Offset(74,125)), true);

    //2.Quadrant
    expect(circleBlock.isClicked(Offset(65,65)), true);
    expect(circleBlock.isClicked(Offset(64,64)), false);
    expect(circleBlock.isClicked(Offset(64,65)), false);
    expect(circleBlock.isClicked(Offset(74,75)), true);

  });
}