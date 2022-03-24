import 'dart:async';

import 'package:flame/components.dart';

import 'package:trex_run/constants.dart';
import 'package:trex_run/enemies/enemy.dart';

class Bat extends Enemy {
  Bat()
      : super(
          sprite: kBatFlying,
          spriteSize: Vector2(46, 30),
        );

  @override
  void resize(Vector2 canvasSize) {
    size = Vector2(
      canvasSize.y / 7,
      canvasSize.y / 7,
    );

    spawnPosition = canvasSize.x;
    // + canvasSize.x;

    position = Vector2(
      canvasSize.x + canvasSize.x,
      canvasSize.y - ((size.y / 2) + 120),
    );
  }

  FutureOr<void> fly() async {
    final fly = (await spriteSheet).createAnimation(
      row: 0,
      from: 0,
      to: 7,
      stepTime: 0.1,
    );

    animation = fly;
  }
}
