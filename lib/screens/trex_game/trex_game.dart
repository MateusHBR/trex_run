import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:trex_run/constants.dart';

class TRexGame extends FlameGame {
  SpriteAnimationComponent? dinoAnimationComponent;

  @override
  Future<void>? onLoad() async {
    await _loadParalax();
    await _loadDino();

    onGameResize(canvasSize);
    return super.onLoad();
  }

  @override
  void onGameResize(canvasSize) {
    if (dinoAnimationComponent != null) {
      dinoAnimationComponent!.size = Vector2(
        canvasSize.y / 5,
        canvasSize.y / 5,
      );
      dinoAnimationComponent!.position = Vector2(
        40,
        canvasSize.y - (dinoAnimationComponent!.size.y + 20),
      );
    }
    super.onGameResize(canvasSize);
  }

  Future<void> _loadDino() async {
    final dinoSheet = SpriteSheet(
      image: await images.load(kDino),
      srcSize: Vector2(24, 24),
    );

    // final dinoSpriteComponent = SpriteComponent(
    //   sprite: dinoSheet.getSprite(0, 0),
    //   position: Vector2(50, 100),
    //   size: spriteSize,
    // );

    /// dino
    /// idle -> 0,3
    /// run -> 4,10
    /// kick -> 11,13
    /// hit ->  14,16
    /// Sprint -> 17,23
    final dinoIdle = dinoSheet.createAnimation(
      row: 0,
      from: 0,
      to: 3,
      stepTime: 0.1,
    );

    final dinoRun = dinoSheet.createAnimation(
      row: 0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    );

    dinoAnimationComponent = SpriteAnimationComponent(
      animation: dinoRun,
      position: Vector2(50, 200),
    );

    add(dinoAnimationComponent!);
  }

  Future<void> _loadParalax() async {
    final paralaxJungle = await loadParallaxComponent(
      kJungleParalax
          .map(
            (image) => ParallaxImageData(image),
          )
          .toList(),
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.2, 0),
    );

    add(paralaxJungle);
  }
}
