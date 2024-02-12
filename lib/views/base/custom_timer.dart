import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

Widget customTimer(int _duration, CountDownController _controller,
    bool timerEnded, BuildContext context, ValueChanged<bool> onValueChange) {
  bool firstTime = true;

  return CircularCountDownTimer(
    duration: _duration,

    // Countdown initial elapsed Duration in Seconds.
    initialDuration: 0,

    // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
    controller: _controller,

    // Width of the Countdown Widget.
    width: MediaQuery.of(context).size.width / 2,

    // Height of the Countdown Widget.
    height: MediaQuery.of(context).size.height / 2,

    // Ring Color for Countdown Widget.
    ringColor: Colors.grey[300]!,

    // Ring Gradient for Countdown Widget.
    ringGradient: null,

    // Filling Color for Countdown Widget.
    fillColor: Colors.purpleAccent[100]!,

    // Filling Gradient for Countdown Widget.
    fillGradient: null,

    // Background Color for Countdown Widget.
    backgroundColor: Colors.purple[500],

    // Background Gradient for Countdown Widget.
    backgroundGradient: null,

    // Border Thickness of the Countdown Ring.
    strokeWidth: 20.0,

    // Begin and end contours with a flat edge and no extension.
    strokeCap: StrokeCap.round,

    // Text Style for Countdown Text.
    textStyle: const TextStyle(
      fontSize: 33.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),

    // Format for the Countdown Text.
    textFormat: CountdownTextFormat.MM_SS,

    // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
    isReverse: true,

    // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
    isReverseAnimation: true,

    // Handles visibility of the Countdown Text.
    isTimerTextShown: true,

    // Handles the timer start.
    autoStart: false,

    // This Callback will execute when the Countdown Starts.
    onStart: () {
      firstTime = false;
      // Here, do whatever you want
      debugPrint('Countdown Started');
    },

    // This Callback will execute when the Countdown Ends.
    onComplete: () {
      // Here, do whatever you want
      debugPrint('Countdown Ended');
      print(_controller.isRestarted);
      print(_controller.getTime());
      // timerEnded = true;
      onValueChange(true);
    },

    // This Callback will execute when the Countdown Changes.
    onChange: (String timeStamp) {
      // Here, do whatever you want
      debugPrint('Countdown Changed $timeStamp');
    },

    /* 
                * Function to format the text.
                * Allows you to format the current duration to any String.
                * It also provides the default function in case you want to format specific moments
                  as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
                  the default behavior.
              */
    timeFormatterFunction: (defaultFormatterFunction, duration) {
      if (duration.inSeconds == 0 && firstTime) {
        // only format for '0'
        return "Test Ended";
      } else if (duration.inSeconds == 0 && !firstTime) {
        return "Test Ended";
      } else {
        // other durations by it's default format
        return Function.apply(defaultFormatterFunction, [duration]);
      }
    },
  );
}
