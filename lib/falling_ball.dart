import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class FallingBall extends StatefulWidget {
  const FallingBall({super.key});

  @override
  State<FallingBall> createState() => _FallingBallState();
}

class _FallingBallState extends State<FallingBall> {
  double ballY = 0.0;
  double ballSpeed = 2.0;
  int score = 0;
  bool gameStarted = false;
  bool gamePaused = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  void startGame() {
    gameStarted = true;
    gamePaused = false;
    ballY = MediaQuery.of(context).size.height / 2;
    score = 0;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!gamePaused) {
        setState(() {
          ballY += ballSpeed;
          if (ballY <= 0 || ballY >= MediaQuery.of(context).size.height) {
            gameOver();
          }
        });
      }
    });
  }

  void gameOver() {
    gamePaused = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Гра закінчена!'),
          content: Text('Ваш рахунок: $score'),
          actions: <Widget>[
            TextButton(
              child: const Text('Нова гра'),
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(seconds: 1), () {
                  startGame();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void changeDirection() {
    setState(() {
      if (!gameStarted) {
        startGame();
      }
      score++;
      ballSpeed *= -1;
    });
    audioPlayer.play(AssetSource('mp3/hit_ball.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeDirection();
      },
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  top: ballY - 25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Рахунок: $score',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
