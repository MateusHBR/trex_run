import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'dart:math' as math;

import 'package:trex_run/enemies/enemy.dart';
import 'package:trex_run/screens/trex_game/trex_game.dart';

class EnemySpawner extends Component with HasGameRef<TRexGame> {
  EnemySpawner({
    required this.enemies,
  }) {
    _timer = Timer(
      4,
      repeat: true,
      onTick: spawnRandonEnemy,
    );
  }

  Timer? _timer;
  int _spawnLevel = 0;
  final List<Enemy> enemies;
  final _random = math.Random();

  void spawnRandonEnemy() {
    final randomNumber = _random.nextInt(enemies.length);

    final enemy = enemies[randomNumber];

    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();

    _timer!.start();
  }

  @override
  void render(Canvas canvas) {}

  @override
  void update(double dt) {
    _timer!.update(dt);

    var newSpawnLevel = (gameRef.score ~/ 500);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;
      final newWaitTime = (4 / (1 + (0.1 * newSpawnLevel)));

      _timer!.stop();

      print('New level: $newWaitTime');

      _timer = Timer(
        newWaitTime,
        repeat: true,
        onTick: spawnRandonEnemy,
      );
      _timer!.start();
    }
  }
}
