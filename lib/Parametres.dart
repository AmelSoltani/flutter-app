import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj/modif_inf.dart';
import 'LoginScreen.dart';
import 'Graph.dart';
import 'Notifications.dart';
import 'modif_inf.dart';

class Parametres extends StatelessWidget {
  static final String path = "lib/src/pages/settings/settings2.dart";
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text(
          'Paramètres',
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
              child: Text(
                'Bonjour',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
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
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                ListTile(
                  title: Text(
                    "Modifier les information d'ultilisateur",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Modif()));
                  },
                ),
                SwitchListTile(
                  title: Text(
                    "Envoyer une alerte à l'utilisateur",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  activeColor: Colors.red[600],
                  subtitle: Text(
                    "On",
                    style: greyTExt,
                  ),
                  value: false,
                  onChanged: (val) {},
                ),
                ListTile(
                  title: Text(
                    "Déconnecter",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
