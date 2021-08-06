import 'dart:async';

class TimeKeeper {
  // Think this all can be replaced by Dart's built-in Stopwatch class?
  // int _counter = 0;  // Total number of milliseconds elapsed
  // late Stream<int> _millisecondStream = Stream<int>.periodic(const Duration(milliseconds: 1), (x) => x);
  // late StreamSubscription<int> _subscription;
  //
  // void _incrementCounter() => _counter++;
  //
  // void startCounter() =>
  //     _subscription = _millisecondStream.listen((event) => _incrementCounter());
  //
  // void stopCounter() =>
  //     _subscription.cancel();
  //
  // int get elapsed => _counter;


  Stopwatch _clock = Stopwatch();

  void start() => _clock.start();

  void stop() => _clock.stop();

  void reset() => _clock.reset();

  Duration get elapsed => _clock.elapsed;

}