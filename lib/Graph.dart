import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'Parametres.dart';
import 'graphdata.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          title: Text(
            'Historique',
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Bonjour',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
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
        body: GraphData());
  }
}

  
  /* Future<void> gettempCollectionFromFirebase() async {
    final String uid = await getCurrentUID();
    CollectionReference temp = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('temp');

    DocumentSnapshot snapshot = await temp.doc('tempjour').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['tempjour'] as List<dynamic>;
      categoriesData.forEach((catData) {
        TemperatureData cat = TemperatureData.fromJson(catData);
        _chartData.add(cat);
      });
    }
  }*/

