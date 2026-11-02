import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../cyber_runner_game.dart';

class RunnerPlayer extends PositionComponent 
    with HasGameReference<CyberRunnerGame>, CollisionCallbacks {
  
  static const double gravity = 980.0;
  static const double jumpForce = -420.0;
  
  double velocityY = 0.0;
  bool isGrounded = true;
  int jumpCount = 0;
  final int maxJumps = 2; // Çift zıplama (Double Jump)
  final double groundY;

  RunnerPlayer({required Vector2 position}) 
      : groundY = position.y,
        super(position: position, size: Vector2(48, 56), anchor: Anchor.center) {
    // Çarpışma kutusu (Hitbox) ekle
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Yerçekimi fiziği
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    // Zemine basma kontrolü
    if (position.y >= groundY) {
      position.y = groundY;
      velocityY = 0;
      isGrounded = true;
      jumpCount = 0;
    }
  }

  void jump() {
    if (jumpCount < maxJumps) {
      velocityY = jumpForce;
      jumpCount++;
      isGrounded = false;
      // FlameAudio.play('jump.wav');
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Karakter gövdesi (Sprite yokken neon stil çizim)
    final paint = Paint()
      ..color = jumpCount == 2 ? Colors.amberAccent : Colors.cyanAccent
      ..style = PaintingStyle.fill;
    
    final rrect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(8),
    );
    canvas.drawRRect(rrect, paint);

    // Gözler (Koşu yönü detayı)
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(size.x * 0.7, size.y * 0.35), 4, eyePaint);
  }

  void resetPosition(Vector2 pos) {
    position = pos;
    velocityY = 0;
    jumpCount = 0;
    isGrounded = true;
  }
}
