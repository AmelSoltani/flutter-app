import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loading.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var _email, _mdp, _mobile, _adresse;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FormScreen() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _mdp);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Mot de passe est faible"))
            ..show();
          return null;
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context, title: "Error", body: Text("Email est utilisé"))
            ..show();
          return null;
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

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
                    UserCredential response = await FormScreen();
                    String id = (await FirebaseAuth.instance.currentUser)!
                        .uid
                        .toString();
                    print("===================");
                    if (response != null) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(id)
                          .set({
                        'email': _email,
                        'mobile': _mobile,
                        'adresse': _adresse
                      });
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreen()));
                    }
                  },
                  child: Text(
                    'Créer un compte',
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
