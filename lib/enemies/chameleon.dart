import 'dart:async';
import 'package:flame/components.dart';

import 'package:trex_run/constants.dart';
import 'package:trex_run/enemies/enemy.dart';

class Chameleon extends Enemy {
  Chameleon()
      : super(
          sprite: kChameleonRun,
          spriteSize: Vector2(84, 38),
        );

  @override
  void resize(Vector2 canvasSize) {
    size = Vector2(
      canvasSize.y / 6,
      canvasSize.y / 6,
    );

    spawnPosition = canvasSize.x;
    // + canvasSize.x;

    position = Vector2(
      canvasSize.x + canvasSize.x,
      canvasSize.y - ((size.y / 2) + 20),
    );
  }

  FutureOr<void> run() async {
    final run = (await spriteSheet).createAnimation(
      row: 0,
      from: 0,
      to: 8,
      stepTime: 0.1,
    );

    animation = run;
  }
}
