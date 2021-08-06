class TimeKeeper {

  // TODO: Organize these nicer
  Stopwatch _clock = Stopwatch();

  void start() => _clock.start();

  void stop() {
    _clock.stop();
    lap();  // Show final lap time
  }

  void reset() {
    _laps.clear();
    _clock.reset();
  }

  // Log lap time (time between now and cumulative time up to end of last lap)
  void lap() {
    if (_laps.length > 0) {
      _laps.add(_clock.elapsed - _laps.fold(Duration(), (prev, element) => prev + element));
    } else {
      _laps.add(_clock.elapsed);
    }
  }

  Duration get elapsed => _clock.elapsed;

  List<Duration> _laps = [];

  List<Duration> get laps => _laps;

}