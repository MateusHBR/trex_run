import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:trex_run/constants.dart';
import 'package:trex_run/enemies/enemy.dart';
import 'package:trex_run/enemies/enemy_data.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';

class EnemySpawner extends Component with HasGameRef<TRexGame> {
  final List<EnemyData> _data = [];

  final math.Random _random = math.Random();

  final Timer _timer = Timer(3, repeat: true);

  EnemySpawner() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y - 24,
    );

    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.size = enemyData.textureSize;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }

    if (_data.isEmpty) {
      _data.addAll([
        EnemyData(
          image: gameRef.images.fromCache(kChameleonRun),
          nFrames: 8,
          stepTime: 0.1,
          textureSize: Vector2(84, 38),
          speedX: 80,
          canFly: false,
        ),
        EnemyData(
          image: gameRef.images.fromCache(kGhostIdle),
          nFrames: 10,
          stepTime: 0.1,
          textureSize: Vector2(44, 30),
          speedX: 100,
          canFly: true,
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
