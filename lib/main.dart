import 'package:flutter/material.dart';
import 'package:game_ball/falling_ball.dart';

void main() {
  runApp(const FallingBallGame());
}

class FallingBallGame extends StatelessWidget {
  const FallingBallGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FallingBall(),
      ),
    );
  }
}
