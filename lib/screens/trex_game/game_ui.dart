import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trex_run/characters/player.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';
import 'package:trex_run/service_locator.dart';

class GameUi extends StatelessWidget {
  static const id = 'GameUi';

  const GameUi({super.key});

  @override
  Widget build(BuildContext context) {
    final gameRef = locator<TRexGame>();

    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, score, __) {
                    return Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    );
                  },
                ),
              ],
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.lives,
              builder: (_, lives, __) {
                return Row(
                  children: List.generate(3, (index) {
                    if (index < lives) {
                      return const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      );
                    } else {
                      return const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      );
                    }
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
