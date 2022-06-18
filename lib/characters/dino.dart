import 'dart:ui';
import 'package:flame/components.dart';
import 'package:trex_run/characters/player.dart';
import 'package:flame/collisions.dart';
import 'package:trex_run/enemies/enemy.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';

const kGravity = 800.0;

enum DinoAnimationStates {
  idle(0, 3),
  run(4, 10),
  kick(11, 13),
  hit(14, 16),
  sprint(17, 23);

  const DinoAnimationStates(
    this.animationStartInterval,
    this.animationEndInterval,
  );

  final int animationStartInterval;
  final int animationEndInterval;
}

class Dino extends SpriteAnimationGroupComponent<DinoAnimationStates>
    with CollisionCallbacks, HasGameRef<TRexGame> {
  static final _animationMap = {
    DinoAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
    ),
    DinoAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4) * 24, 0),
    ),
    DinoAnimationStates.kick: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6) * 24, 0),
    ),
    DinoAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4) * 24, 0),
    ),
    DinoAnimationStates.sprint: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4 + 3) * 24, 0),
    ),
  };

  double yMax = 0.0;

  double speedY = 0.0;

  final Timer _hitTimer = Timer(1);

  final PlayerData playerData;

  bool isHit = false;

  Dino(
    Image image,
    this.playerData,
  ) : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    // First reset all the important properties, because onMount()
    // will be called even while restarting the game.
    _reset();

    // Add a hitbox for dino.
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    yMax = y;

    /// Set the callback for [_hitTimer].
    _hitTimer.onTick = () {
      current = DinoAnimationStates.run;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    // final velocity = initial velocity + gravity * time
    speedY += kGravity * dt;

    // distance = speed * time
    y += speedY * dt;

    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != DinoAnimationStates.hit) &&
          (current != DinoAnimationStates.run)) {
        current = DinoAnimationStates.run;
      }
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (y >= yMax);

  void jump() {
    if (isOnGround) {
      speedY = -300;
      current = DinoAnimationStates.idle;
    }
  }

  void hit() {
    isHit = true;
    current = DinoAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, gameRef.size.y - 22);
    size = Vector2.all(24);
    current = DinoAnimationStates.run;
    isHit = false;
    speedY = 0.0;
  }
}
