import 'dart:async';
import 'package:flutter/material.dart';
import 'models/time_keeper.dart';
import 'styles.dart';
import 'lap_list_view.dart';

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


  // Display and timer functions
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

  void logLap() {
    _timeKeeper.lap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: standardPadding * 5),
          Center(
            child: Text(
              '${_displayTime.toString()}',
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: standardPadding),
          Padding(
            padding: EdgeInsets.all(standardPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () => _counting ? logLap() : null,
                  style: TextButton.styleFrom(
                    backgroundColor: backgroundColor,
                    primary: Colors.white,
                    minimumSize: const Size(80.0, 80.0),
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade500,
                      )
                    ),
                  ),
                  child: Text('Lap'),
                ),
                SizedBox(width: standardPadding * 4),
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
          ),
          ListTile(
            title:Text(
              'Laps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
              ),
            ),
          ),
          Expanded(
            child: LapListView(
              lapList: _timeKeeper.laps,
            ),
          ),
        ],
      ),
    );
  }
}