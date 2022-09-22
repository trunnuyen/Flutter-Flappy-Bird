import 'package:flappy_bird/model/bird.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double initPos = birdY;
  double time = 0;
  double height = 0;
  double gravity = -4.9;
  double velocity = 3.0;
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initPos - height;
      });

      if (gameOver()) {
        timer.cancel();
        gameHasStarted = false;
        resetGame();
      }

      time += 0.01;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initPos = birdY;
    });
  }

  bool gameOver() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    setState(() {
      birdY = 0;
      initPos = birdY;
      time = 0;
      height = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg5.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        MyBird(birdY: birdY),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
