import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_timer/helper/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => TimerInitialState(_duration);

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStartedEvent) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPausedEvent) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumedEvent) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerResetEvent) {
      yield* _mapTimerResetToState(event);
    } else if (event is TimerTickedEvent) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStartedEvent start) async* {
    yield TimerRunInProgressState(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTickedEvent(duration: duration)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPausedEvent pause) async* {
    if (state is TimerRunInProgressState) {
      _tickerSubscription?.pause();
      yield TimerRunPauseState(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumedEvent resume) async* {
    if (state is TimerRunPauseState) {
      _tickerSubscription?.resume();
      yield TimerRunInProgressState(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerResetEvent reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitialState(_duration);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTickedEvent tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgressState(tick.duration)
        : TimerRunCompleteState();
  }
}
