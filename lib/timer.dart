import 'dart:async';
import 'package:echofi_fitness/styles.dart';
import 'package:flutter/material.dart';
import 'models/time_keeper.dart';

class Timer extends StatefulWidget {
  Timer({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  TimeKeeper _timeKeeper = TimeKeeper();
  bool _counting = false;
  Duration _displayTime = Duration();

  // Event every 0.5 ms to update display properly
  late Stream<int> _updateDisplay;
  late StreamSubscription<int>? _subscription;

  void startDisplayUpdate() {
    _updateDisplay = Stream<int>.periodic(const Duration(microseconds: 1), (x) => x);
    _subscription = _updateDisplay.listen((event) {
      print(event);
      setState(() => _displayTime = _timeKeeper.elapsed);
    });
  }

  void startTimer() {
    _timeKeeper.reset();
    setState(() => _displayTime = _timeKeeper.elapsed);
    startDisplayUpdate();
    _timeKeeper.start();
  }

  void stopTimer() {
    _timeKeeper.stop();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_displayTime.toString()}',
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: standardPadding),
            Padding(
              padding: EdgeInsets.all(standardPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_counting) {
                        stopTimer();
                        setState(() => _counting = false);
                      } else {
                        startTimer();
                        setState(() => _counting = true);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: _counting ? Colors.red : Colors.deepPurple,
                      primary: Colors.white,
                      minimumSize: const Size(80.0, 80.0),
                      shape: const CircleBorder(),
                    ),
                    child: _counting ? Text('Stop') : Text('Start'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}