class Ticker {
  // create a stream of seconds to the UI
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x -1)
      .take(ticks);
  }
 }
