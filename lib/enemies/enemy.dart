import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

abstract class Enemy extends SpriteAnimationComponent {
  Enemy({
    required this.sprite,
    required this.spriteSize,
  }) : super() {
    _loadSprite();
    anchor = Anchor.center;
  }

  final String sprite;
  final Vector2 spriteSize;

  final _spriteSheet = Completer<SpriteSheet>();
  var spawnPosition = 0.0;
  var speed = 200.0;

  Future<SpriteSheet> get spriteSheet => _spriteSheet.future;

  Future<void> _loadSprite() async {
    final spriteSheet = await Flame.images.load(sprite);

    _spriteSheet.complete(
      SpriteSheet(
        image: spriteSheet,
        srcSize: spriteSize,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= speed * dt;

    // with this we know that the enemy is completly outside screen
    // if (x < (-width)) {
    //   x = spawnPosition;
    // }
  }

  void resize(Vector2 canvasSize) {
    size = Vector2(
      canvasSize.y / 5,
      canvasSize.y / 5,
    );

    spawnPosition = canvasSize.x;
    // + canvasSize.x;

    position = Vector2(
      canvasSize.x + canvasSize.x,
      canvasSize.y - (size.y + 20),
    );
  }
}
