import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  @override
  TimerState get initialState => TimerInitial();

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}