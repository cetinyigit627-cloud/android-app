import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'components/runner_player.dart';
import 'components/obstacle.dart';
import 'components/coin.dart';

class CyberRunnerGame extends FlameGame 
    with HasCollisionDetection, TapCallbacks, KeyboardEvents {
  
  late RunnerPlayer player;
  int score = 0;
  int coins = 0;
  late TextComponent scoreText;
  
  double spawnTimer = 0.0;
  double spawnInterval = 2.0;
  final Random _random = Random();
  bool isGameOver = false;

  @override
  Color backgroundColor() => const Color(0xFF0F172A);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 1. Sesleri önbelleğe yükle
    // FlameAudio.audioCache.loadAll(['jump.wav', 'coin.wav', 'hit.wav']);

    // 2. Oyuncuyu ekle
    player = RunnerPlayer(
      position: Vector2(80, size.y - 120),
    );
    add(player);

    // 3. HUD (Arayüz Metinleri)
    scoreText = TextComponent(
      text: 'SKOR: 0  |  ALTIN: 0',
      position: Vector2(24, 24),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.cyanAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
    add(scoreText);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    // Zaman geçtikçe skor artışı
    score += (dt * 15).toInt();
    scoreText.text = 'SKOR: $score  |  ALTIN: $coins';

    // Engel ve Altın Üretimi
    spawnTimer += dt;
    if (spawnTimer >= spawnInterval) {
      spawnTimer = 0.0;
      // Zorluğu kademeli artır
      spawnInterval = max(1.1, spawnInterval * 0.98);

      _spawnObstacleOrCoin();
    }
  }

  void _spawnObstacleOrCoin() {
    if (_random.nextBool()) {
      add(Obstacle(position: Vector2(size.x + 20, size.y - 100)));
    } else {
      add(Coin(position: Vector2(size.x + 20, size.y - 140)));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!isGameOver) {
      player.jump();
    }
  }

  void triggerGameOver() {
    isGameOver = true;
    pauseEngine();
    overlays.add('GameOver');
  }

  void resetGame() {
    isGameOver = false;
    score = 0;
    coins = 0;
    spawnInterval = 2.0;
    
    // Sahnedeki engel ve paraları temizle
    children.whereType<Obstacle>().forEach((o) => o.removeFromParent());
    children.whereType<Coin>().forEach((c) => c.removeFromParent());

    player.resetPosition(Vector2(80, size.y - 120));
    resumeEngine();
  }
}
