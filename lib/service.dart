import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  var fbm = FirebaseMessaging.instance;

  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      Navigator.of(context).pushNamed("Notifications");
    }
  }

  requestPermssion() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    requestPermssion();
    initalMessage();
    fbm.getToken().then((token) {
      print("=================== Token ==================");
      print(token);
      print("====================================");
    });
    FirebaseMessaging.onMessage.listen((event) {
      print(
          "===================== data Notification ==============================");

      AwesomeDialog(
          context: context,
          title: "title",
          body: Text("${event.notification!.body}"))
        ..show();

      Navigator.of(context).pushNamed("Notifications");
    });

    getCurrentUID();
    super.initState();
  }

  Future<String> getCurrentUID() async {
    final String id = (await FirebaseAuth.instance.currentUser)!.uid.toString();
    return id;
  }

  saveDeviceToken() async {
    // Get the current user
    // User? user = await FirebaseAuth.instance.currentUser;
    // Get the token for this device
    String? fcmToken = await fbm.getToken();
    final String uid = await getCurrentUID();
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
          _db.collection('users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
