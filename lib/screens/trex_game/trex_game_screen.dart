import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trex_run/screens/trex_game/game_ui.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';
import 'package:trex_run/service_locator.dart';

import 'game_over.dart';

class TRexGameScreen extends StatefulWidget {
  const TRexGameScreen({
    super.key,
  });

  @override
  State<TRexGameScreen> createState() => _TRexGameScreenState();
}

class _TRexGameScreenState extends State<TRexGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        loadingBuilder: (conetxt) => const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        ),
        overlayBuilderMap: {
          GameOverMenu.id: (_, __) => const GameOverMenu(),
          GameUi.id: (_, __) => const GameUi(),
        },
        initialActiveOverlays: const [GameUi.id],
        key: const Key('GamePresentation'),
        game: locator<TRexGame>(),
      ),
    );
  }
}
