import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../cyber_runner_game.dart';
import 'runner_player.dart';

class Coin extends PositionComponent 
    with HasGameReference<CyberRunnerGame>, CollisionCallbacks {
  
  static const double moveSpeed = 260.0;

  Coin({required Vector2 position}) 
      : super(position: position, size: Vector2(24, 24), anchor: Anchor.center) {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= moveSpeed * dt;
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is RunnerPlayer) {
      game.coins += 1;
      game.score += 50;
      // FlameAudio.play('coin.wav');
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.amber;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
