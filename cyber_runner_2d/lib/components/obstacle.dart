import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../cyber_runner_game.dart';
import 'runner_player.dart';

class Obstacle extends PositionComponent 
    with HasGameReference<CyberRunnerGame>, CollisionCallbacks {
  
  static const double moveSpeed = 260.0;

  Obstacle({required Vector2 position}) 
      : super(position: position, size: Vector2(36, 44), anchor: Anchor.bottomCenter) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Sola doğru kayma
    position.x -= moveSpeed * dt;

    // Ekrandan çıkınca bellekten temizle
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is RunnerPlayer) {
      game.triggerGameOver();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;

    // Sivri diken veya lazer bariyeri çizimi
    final path = Path()
      ..moveTo(0, size.y)
      ..lineTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..close();

    canvas.drawPath(path, paint);
  }
}
