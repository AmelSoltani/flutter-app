import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

showprint() {
  print('un incendie a été detecté en ${DateTime.now()}');
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: OutlinedButton(
            child: Text('Alarm now'),
            onPressed: () {
              AndroidAlarmManager.oneShot(Duration(seconds: 3), 0, showprint);
            },
          ),
        ),
      ),
    );
  }
}
