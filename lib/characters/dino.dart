import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:trex_run/constants.dart';

const kGravity = 1000.0;

/// dino
/// idle -> 0,3
/// run -> 4,10
/// kick -> 11,13
/// hit ->  14,16
/// Sprint -> 17,23
class Dino extends SpriteAnimationComponent {
  Dino() : super() {
    _loadSprite();
    _timer = Timer(1, onTick: () {
      run();
    });

    anchor = Anchor.center;
  }

  Future<void> _loadSprite() async {
    final spriteSheet = await Flame.images.load(kDino);

    _sprite.complete(
      SpriteSheet(
        image: spriteSheet,
        srcSize: Vector2(24, 24),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isNotOnGround()) {
      run();
    }
    // final velocity = initial velocity + gravity * time
    speedY += kGravity * dt;

    // distance = speed * time
    y += speedY * dt;

    if (isNotOnGround()) {
      y = yMax;
      speedY = 0.0;
    }

    _timer!.update(dt);
  }

  final _sprite = Completer<SpriteSheet>();

  var speedY = 0.0;
  var yMax = 0.0;
  var _hasDamage = false;
  Timer? _timer;

  bool isNotOnGround() {
    return y >= yMax;
  }

  void resize(Vector2 canvasSize) {
    size = Vector2(
      canvasSize.y / 5,
      canvasSize.y / 5,
    );
    position = Vector2(
      40,
      canvasSize.y - ((size.y / 2) + 20),
    );

    yMax = y;
  }

  void jump() {
    if (isNotOnGround()) {
      speedY = -500;
    }
  }

  FutureOr<void> idle() async {
    final idle = (await _sprite.future).createAnimation(
      row: 0,
      from: 0,
      to: 3,
      stepTime: 0.1,
    );

    animation = idle;
  }

  FutureOr<void> run() async {
    _hasDamage = false;
    final run = (await _sprite.future).createAnimation(
      row: 0,
      from: 4,
      to: 10,
      stepTime: 0.1,
    );

    animation = run;
  }

  FutureOr<void> kick() async {
    final kick = (await _sprite.future).createAnimation(
      row: 0,
      from: 11,
      to: 13,
      stepTime: 0.1,
    );

    animation = kick;
  }

  FutureOr<void> damage() async {
    if (!_hasDamage) {
      _timer!.start();
      final damage = (await _sprite.future).createAnimation(
        row: 0,
        from: 14,
        to: 16,
        stepTime: 0.1,
      );
      animation = damage;
      _hasDamage = true;
    }
  }

  FutureOr<void> sprint() async {
    final sprint = (await _sprite.future).createAnimation(
      row: 0,
      from: 17,
      to: 23,
      stepTime: 0.1,
    );

    animation = sprint;
  }
}
