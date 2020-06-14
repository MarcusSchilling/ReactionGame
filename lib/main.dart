import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reaction/game_page.dart';
import 'package:reaction/util/size_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Reaction Game',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Reaction Game'),
    );
  }
}
