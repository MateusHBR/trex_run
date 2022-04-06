import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:trex_run/characters/dino.dart';
import 'package:trex_run/constants.dart';
import 'package:trex_run/enemies/chameleon.dart';
import 'package:trex_run/enemies/enemy.dart';
import 'package:trex_run/enemies/ghost.dart';
import 'package:trex_run/mechanics/enemy_spawner.dart';

class TRexGame extends FlameGame with TapDetector {
  final _dino = Dino();
  final _ghost = Ghost();
  final _chameleon = Chameleon();

  final _scoreText = TextComponent();
  int score = 0;

  @override
  Future<void>? onLoad() async {
    await _loadParalax();
    await _setupEnemies();

    final enemySpawner = EnemySpawner(enemies: [
      _ghost,
      _chameleon,
    ]);
    add(enemySpawner);

    _dino.resize(canvasSize);
    _dino.run();
    add(_dino);

    _scoreText.text = score.toString();
    add(_scoreText);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    _dino.jump();
    super.onTapDown(info);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _scoreText.position =
        Vector2((canvasSize.x / 2) - (_scoreText.width / 2), 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    score += (60 * dt).toInt();
    _scoreText.text = score.toString();

    children.whereType<Enemy>().forEach((enemy) {
      if (_dino.distance(enemy) < 20) {
        _dino.damage();
      }
    });
  }

  Future<void> _loadParalax() async {
    // final paralaxJungle = await loadParallaxComponent(
    //   kJungleParalax
    //       .map(
    //         (image) => ParallaxImageData(image),
    //       )
    //       .toList(),
    //   baseVelocity: Vector2(100, 0),
    //   velocityMultiplierDelta: Vector2(1.2, 0),
    // );

    final paralaxDesert = await loadParallaxComponent(
      kDesertParalax
          .map(
            (image) => ParallaxImageData(image),
          )
          .toList(),
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.2, 0),
    );

    add(paralaxDesert);
  }

  Future<void> _setupEnemies() async {
    _ghost.resize(canvasSize);
    await _ghost.idle();

    _chameleon.resize(canvasSize);
    await _chameleon.run();
  }
}
