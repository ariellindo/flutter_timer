part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [];
}

class TimerInitialState extends TimerState {
  const TimerInitialState(int duration) : super(duration);

  @override
  String toString() => 'TimerInitialState { duration: $duration }';
}

class TimerRunPauseState extends TimerState {
  const TimerRunPauseState(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPauseState { duration: $duration }';
}

class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgressState { duration: $duration }';
}

class TimerRunCompleteState extends TimerState {
  const TimerRunCompleteState() : super(0);
}
