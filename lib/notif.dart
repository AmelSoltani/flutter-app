import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserInformation extends StatefulWidget {
  UserInformation() : super();
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<String> getCurrentUID() async {
    final String id = (await FirebaseAuth.instance.currentUser)!.uid.toString();
    return id;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUID();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Row(children: [
      Expanded(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Alerte :',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Wrap(
            children: [
              Text('Température: ', style: TextStyle(fontSize: 18)),
              Text("${document['temperature']}",
                  style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 15),
          Wrap(
            children: [
              Text(
                'Date: ',
                style: TextStyle(fontSize: 18),
              ),
              Text(timeago.format(document['date'].toDate()).toString(),
                  style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 30),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUserstempStreamSnapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) =>
              _buildListItem(context, snapshot.data!.docs[index]),
        );
      },
    );
  }

  Stream<QuerySnapshot> getUserstempStreamSnapshots() async* {
    final String uid = await getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('temp')
        .snapshots();
  }
}
