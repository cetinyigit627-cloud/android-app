import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cyber_runner_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Tam ekran modu ve yatay ekran sabitleme
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget<CyberRunnerGame>(
          game: CyberRunnerGame(),
          overlayBuilderMap: {
            'GameOver': (context, game) => GameOverOverlay(game: game),
            'PauseMenu': (context, game) => PauseMenuOverlay(game: game),
          },
        ),
      ),
    ),
  );
}

class GameOverOverlay extends StatelessWidget {
  final CyberRunnerGame game;
  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.cyanAccent, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'OYUN BİTTİ!',
              style: TextStyle(color: Colors.redAccent, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Skor: ${game.score}',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
              onPressed: () {
                game.resetGame();
                game.overlays.remove('GameOver');
              },
              child: const Text('Tekrar Oyna', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class PauseMenuOverlay extends StatelessWidget {
  final CyberRunnerGame game;
  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          game.resumeEngine();
          game.overlays.remove('PauseMenu');
        },
        child: const Text('Devam Et'),
      ),
    );
  }
}
