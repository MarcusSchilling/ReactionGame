import 'package:flutter/cupertino.dart';
import 'package:reaction/game/board/building_block/cross_block.dart';
import 'package:test_api/test_api.dart';

main() {
  test('isClicked', () {
    CrossBlock _crossBlock = CrossBlock(Offset(100,100), 100, Color.fromRGBO(100, 100, 100, 100), true);
    expect(_crossBlock.isClicked(Offset(100,100)), true);
    expect(_crossBlock.isClicked(Offset(200,100)), true);
    expect(_crossBlock.isClicked(Offset(0,100)), true);
    expect(_crossBlock.isClicked(Offset(0,150)), true);
    expect(_crossBlock.isClicked(Offset(0,151)), false);
    expect(_crossBlock.isClicked(Offset(0,50)), true);
    expect(_crossBlock.isClicked(Offset(0,49)), false);
    expect(_crossBlock.isClicked(Offset(100,200)), true);
    expect(_crossBlock.isClicked(Offset(100,201)), false);
    expect(_crossBlock.isClicked(Offset(50,200)), true);
    expect(_crossBlock.isClicked(Offset(49,200)), false);
    expect(_crossBlock.isClicked(Offset(50,0)), true);
    expect(_crossBlock.isClicked(Offset(49,0)), false);
  });
}