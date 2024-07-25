import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async'; // Import this for Timer

QuizBrain Qbrain = QuizBrain();

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffF9FEA5),
                  Color(0xff20E2D7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Quiz App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 2.5,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 2,
                  offset: Offset(3, 1),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  int _remainingTime = 10;
  Timer? _timer;
  bool _isAlertShown = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = 10;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        _timer?.cancel();
        if (!_isAlertShown) {
          _showTimeUpAlert();
        }
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _showTimeUpAlert() {
    setState(() {
      _isAlertShown = true;
    });
    Alert(
      context: context,
      title: 'Time\'s Up!',
      desc: 'The time for this question has ended.',
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _isAlertShown = false;
              Qbrain.nextQfunc();
              _startTimer();
            });
          },
        ),
      ],
    ).show();
  }

  void CheckAns(bool UserPickerAns) {
    bool correctAns = Qbrain.getCorrectAns();
    setState(() {
      if (Qbrain.isFinished() == true) {
        _timer?.cancel();
        if (!_isAlertShown) {
          int totalQuestions = Qbrain.getTotalQuestions();
          int totalScore = score;
          String message;
          if (totalScore >= 10) {
            message = 'Congratulations! Your score is $totalScore out of $totalQuestions:)';
          } else {
            message = 'Keep trying! Your score is $totalScore out of $totalQuestions';
          }
          Alert(
            context: context,
            title: 'Quiz Finished',
            desc: message,
            buttons: [
              DialogButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    Qbrain.reset();
                    scorekeeper = [];
                    score = 0;
                    _startTimer();
                  });
                },
              ),
            ],
          ).show();
        }
      } else {
        if (UserPickerAns == correctAns) {
          scorekeeper.add(Icon(
            Icons.check,
            color: Color(0xff0f9b0f),
          ));
          score++;
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Color(0xffdd1818),
          ));
        }
        Qbrain.nextQfunc();
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff20E2D7),
                Color(0xffF9FEA5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time Remaining: $_remainingTime s',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(3, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      Qbrain.getQuestext(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2.5,
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(3, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0f9b0f),
                      elevation: 5, // Adds shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'True',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 2.5,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      CheckAns(true);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffdd1818),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 2.5,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      CheckAns(false);
                    },
                  ),
                ),
              ),
              Row(
                children: scorekeeper,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
