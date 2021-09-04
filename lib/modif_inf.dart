import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Modif extends StatefulWidget {
  Modif() : super();
  @override
  _ModifState createState() => _ModifState();
}

class _ModifState extends State<Modif> {
  var _email, _mdp, _mobile, _adresse;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Le champs Email est obligatoire';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Entrer une adresse email valide';
        }
      },
      onSaved: (value) {
        if (value != null) {
          _email = value;
          print(_email);
        }
      },
    );
  }

  Widget _buildMdp() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Mot de passe'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Le champs Mot de passe est obligatoire';
        }
      },
      onSaved: (value) {
        if (value != null) {
          _mdp = value;
          print(_mdp);
        }
      },
    );
  }

  Widget _buildMobile() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Mobile'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Le champs Mobile est obligatoire';
        }
      },
      onSaved: (value) {
        if (value != null) {
          _mobile = value;
          print(_mobile);
        }
      },
    );
  }

  Widget _buildAdresse() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Adresse'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Le champs Adresse est obligatoire';
        }
      },
      onSaved: (value) {
        if (value != null) {
          _adresse = value;
          print(_adresse);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incendie',
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                    image: AssetImage('assets/db.png'), height: 100, width: 50),
                SizedBox(height: 20),
                _buildEmail(),
                _buildMdp(),
                _buildMobile(),
                _buildAdresse(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser!
                        .updatePassword(_mdp);
                    await FirebaseAuth.instance.currentUser!
                        .updateEmail(_email);
                    String uid = await FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'email': _email,
                      'mobile': _mobile,
                      'adresse': _adresse
                    });
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new LoginScreen()));
                  },
                  child: Text(
                    'Modifier',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
