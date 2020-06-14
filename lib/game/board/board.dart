import 'dart:ui';

import 'package:reaction/game/board/building_block/building_block.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/factories/game_factory.dart';
import 'package:reaction/util/method_not_supported.dart';

class Board {

  List<BuildingBlock> _buildingBlocks = List();
  Finger _finger;

  void addBlock(BuildingBlock buildingBlock) {
    _buildingBlocks.add(buildingBlock);
  }

  void draw(Canvas canvas) {
    _buildingBlocks.forEach((buildingBlock) => buildingBlock.drawOnCanvas(canvas));
  }

  Hit isHit(Offset position) {
    var indexHit = _buildingBlocks.indexWhere((block) => block.isClicked(position));
    if(indexHit == -1) {
      return Hit.NO_HIT;
    } else if(_buildingBlocks.elementAt(indexHit).isTarget()){
      return Hit.CORRECT;
    } else {
      return Hit.WRONG;
    }
  }

  BuildingBlock hitPosition(Offset position) {
    var indexHit = _buildingBlocks.indexWhere((block) => block.isClicked(position));
    if (indexHit == -1) {
      throw new MethodNotSupportedException();
    }
    return _buildingBlocks.where((block) => block.isClicked(position)).first;
  }

  void addTargetFinger(Finger finger) {
    _finger = finger;
  }

  Finger get finger => _finger;


}