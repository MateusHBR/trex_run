import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trex_run/characters/player.dart';
import 'package:trex_run/screens/trex_game/game_ui.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';
import 'package:trex_run/service_locator.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';

  const GameOverMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameRef = locator<TRexGame>();

    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.black.withAlpha(100),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.currentScore,
                        builder: (_, score, __) {
                          return Text(
                            'Sua pontuação: $score',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Reiniciar',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        onPressed: () {
                          gameRef.overlays
                            ..remove(GameOverMenu.id)
                            ..add(GameUi.id);

                          gameRef
                            ..resumeEngine()
                            ..reset()
                            ..startGamePlay();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
