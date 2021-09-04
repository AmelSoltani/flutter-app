import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Parametres.dart';
import 'Graph.dart';
import 'Videosurveillance.dart';
import 'notif.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  /*final _db = FirebaseFirestore.instance;
  get_data() async {
    final User? user = await FirebaseAuth.instance.currentUser;

    return await _db
        .collection('users')
        .doc(user!.uid)
        .collection('temp')
        .doc('tempjour')
        .get();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Vidéosurveillance'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new VideoSurveillance()));
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Historique'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Graph()));
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Notifications'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Notifications()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Paramètres'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Parametres()));
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: UserInformation());
  }

  /*Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              Text(
                'Alerte 1 :',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Température: ', style: TextStyle(fontSize: 18)),
                  Text("${get_data()['temperature'].toString()}",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("${get_data()['date'].toString()}",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: () {}, child: Text('Enregistrement')),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),

              /* body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc('documentId')
              .collection('temp')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Center(
                  data.foreach(dt) {
                  child: Column(children: [
                    Text(
                      'Alerte 1 :',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Température: ', style: TextStyle(fontSize: 18)),
                        Text(dt['temperature'],
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Date: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(dt['date'], style: TextStyle(fontSize: 18)),
                      ],}
                    ),
                  ]),
                );
              }).toList(),
            );
          }),*/
            ])));
  }*/
}
