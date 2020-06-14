
import 'dart:ui';

import 'package:reaction/game/board/building_block/triangle_block.dart';
import 'package:test_api/test_api.dart';

main() {
  test('triangle block is clicked', (){
    TriangleBlock triangle = TriangleBlock(Offset(100, 100), 100, Color.fromRGBO(100, 100, 100, 100), true);
    expect(triangle.isClicked(Offset(100, 100)), true);
    //center
    expect(triangle.isClicked(Offset(100, 100)), true);
    //x1
    expect(triangle.isClicked(Offset(100, 200)), true);
    //x2
    expect(triangle.isClicked(Offset(200, 200)), true);
    //x3
    expect(triangle.isClicked(Offset(0, 0)), true);
  });
}