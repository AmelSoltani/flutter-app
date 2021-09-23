import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proj/LoginScreen.dart';

void initialise() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image: AssetImage('assets/img.jpg'),
            height: 250,
            width: 250,
          ),
        ),
        persistentFooterButtons: [
          Container(
            child: Image(
              image: AssetImage('assets/db.png'),
              height: 80,
              width: 80,
            ),
          )
        ]);
  }
}
