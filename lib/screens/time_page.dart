import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/bloc/timer/timer_bloc.dart';
import 'package:flutter_timer/widgets/actions.dart' as ax;
import 'package:flutter_timer/widgets/background.dart';

class TimerPage extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
      ),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Center(
                  child: BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      print(state.duration);
                      final String minutesStr = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsStr = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$minutesStr:$secondsStr',
                        style: TimerPage.timerTextStyle,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              BlocBuilder<TimerBloc, TimerState>(
                  condition: (previousState, state) =>
                      state.runtimeType != previousState.runtimeType,
                  builder: (context, state) {
                    return ax.Actions();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
