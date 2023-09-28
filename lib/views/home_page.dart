import 'package:flutter/material.dart';

import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRunning = false;
  int total = 1500;
  int pauseTotal = 300;
  late Timer timerPomodoro;
  late Timer timerPause;

  void contadorPomodoro() {
    const oneSec = Duration(seconds: 1);
    timerPomodoro = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (total < 1) {
          timer.cancel();
        } else {
          total = total - 1;
        }
      });
    });
  }

  void contadorPause() {
    const oneSec = Duration(seconds: 1);
    timerPause = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (pauseTotal < 1) {
          timer.cancel();
        } else {
          pauseTotal = pauseTotal - 1;
        }
      });
    });
  }

  String formataTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  bool isPauseBeforePlay() {
    if (total < 1500 && isRunning == false) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    timerPause = Timer(Duration.zero, () {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 52),
        child: Center(
            child: Column(
          children: [
            const Text(
              'Relógio Pomodoro',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 150,
            ),
            Text(formataTimer(total),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 80)),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      total = 1500;
                      pauseTotal = 30;
                      timerPomodoro.cancel();
                      timerPause.cancel();
                      isRunning = false;
                    });
                  },
                  child: const Icon(
                    FontAwesomeIcons.arrowRotateLeft,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isRunning = !isRunning;
                      if (isRunning) {
                        timerPause.cancel();
                        pauseTotal = 300;
                        total = 1500;
                        contadorPomodoro();
                      } else {
                        timerPomodoro.cancel();
                        contadorPause();
                      }
                    });
                  },
                  child: Icon(
                      size: 50,
                      isRunning
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play),
                )
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            isPauseBeforePlay()
                ? Column(
                    children: [
                      const Text(
                        'Pause',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black38),
                      ),
                      Text(
                        formataTimer(pauseTotal),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black38),
                      )
                    ],
                  )
                : const SizedBox(
                    height: 40,
                  )
          ],
        )),
      ),
    );
  }
}
