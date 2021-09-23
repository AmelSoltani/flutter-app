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

  final user = FirebaseAuth.instance.currentUser;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UpdatUser() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      await user!.updatePassword(_mdp);
      await user!.updateEmail(_email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(
            {'email': _email, 'mobile': _mobile, 'adresse': _adresse},
          )
          .then((value) => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LoginScreen())))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(Icons.mail_rounded, color: Colors.red[600])),
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
      decoration: InputDecoration(
          labelText: 'Mot de passe',
          icon: Icon(Icons.lock_rounded, color: Colors.red[600])),
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
      decoration: InputDecoration(
          labelText: 'Mobile',
          icon: Icon(Icons.phone_android_rounded, color: Colors.red[600])),
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
      decoration: InputDecoration(
          labelText: 'Adresse',
          icon: Icon(Icons.apartment_rounded, color: Colors.red[600])),
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
        backgroundColor: Colors.red[600],
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
                    await UpdatUser();
                  },
                  child: Text(
                    'Modifier',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
