import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimeDisplay extends StatelessWidget {
  final int seconds;

  const TimeDisplay({Key? key, required this.seconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';

    return Text(
      formattedTime,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }
}
