import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';

class TRexGameScreen extends StatefulWidget {
  const TRexGameScreen({Key? key}) : super(key: key);

  @override
  _TRexGameScreenState createState() => _TRexGameScreenState();
}

class _TRexGameScreenState extends State<TRexGameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        key: const Key('GamePresentation'),
        game: TRexGame(),
      ),
    );
  }
}
