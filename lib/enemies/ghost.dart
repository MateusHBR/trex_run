import 'dart:async';

import 'package:flame/components.dart';

import 'package:trex_run/constants.dart';
import 'package:trex_run/enemies/enemy.dart';

class Ghost extends Enemy {
  Ghost()
      : super(
          sprite: kGhostIdle,
          spriteSize: Vector2(44, 30),
        );

  FutureOr<void> idle() async {
    final idle = (await spriteSheet).createAnimation(
      row: 0,
      from: 0,
      to: 10,
      stepTime: 0.1,
    );

    animation = idle;
  }
}
