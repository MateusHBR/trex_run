import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:trex_run/characters/dino.dart';
import 'package:trex_run/characters/player.dart';
import 'package:trex_run/constants.dart';
import 'package:trex_run/mechanics/enemy_spawner.dart';

import 'game_over.dart';

class TRexGame extends FlameGame with TapDetector, HasCollisionDetection {
  static const _imageAssets = [
    kDino,
    kChameleonRun,
    kGhostIdle,
    ...kDesertParalax,
  ];

  late Dino _dino;
  late PlayerData playerData;
  late EnemySpawner _enemySpawner;

  void startGamePlay() {
    _dino = Dino(images.fromCache(kDino), playerData);
    _enemySpawner = EnemySpawner();

    add(_dino);
    add(_enemySpawner);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll(_imageAssets);
    playerData = PlayerData();

    camera.viewport = FixedResolutionViewport(Vector2(360, 180));

    await _loadParalax();

    startGamePlay();

    return super.onLoad();
  }

  Future<void> _loadParalax() async {
    final paralaxDesert = await loadParallaxComponent(
      kDesertParalax.map((image) => ParallaxImageData(image)).toList().reversed,
      baseVelocity: Vector2(120, 0),
      velocityMultiplierDelta: Vector2(1.05, 0),
    );

    add(paralaxDesert);
  }

  // This method remove all the actors from the game.
  void _disconnectActors() {
    _dino.removeFromParent();
    _enemySpawner.removeAllEnemies();
    _enemySpawner.removeFromParent();
  }

  void reset() {
    _disconnectActors();

    playerData.currentScore = 0;
    playerData.lives = kPlayerLives;
  }

  @override
  void update(double dt) {
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      pauseEngine();
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    _dino.jump();
    super.onTapDown(info);
  }
}
