import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reaction/game/factories/building_block_factory.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/game/factories/game_factory.dart';
import 'package:reaction/game/finite_state_machine/abstract_game_state.dart';
import 'package:reaction/game/finite_state_machine/game.dart';
import 'package:reaction/game/finite_state_machine/game/game_state.dart';
import 'package:reaction/util/size_util.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(4);

}

class _MyHomePageState extends State<MyHomePage> {

  var rounds;
  Game _game;

  _MyHomePageState(this.rounds);

  @override
  Widget build(BuildContext context) {
    if(_game == null) {
      SystemChrome.setEnabledSystemUIOverlays([]);
      SizeUtil.size = MediaQuery.of(context).size;
      _game = Game(rounds);
    }
    return _game.currentWidget(this);
  }


  @override
  void dispose() {
    _game.closeApplication();
    super.dispose();
  }

}
