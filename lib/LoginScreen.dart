import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/Graph.dart';
import 'package:proj/send_email.dart';
import 'FormScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _mdp, _email;
  bool connecte = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _mdp);
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Graph()));

        ///Navigator.of(context).pushReplacementNamed("homepage");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Email n'existe pas "))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Mot de passe est incorrecte"))
            ..show();
        }
      }
    } else {
      print("Invalide");
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 70),
                Image(
                    image: AssetImage('assets/img.jpg'),
                    height: 100,
                    width: 60),
                SizedBox(height: 20),
                _buildEmail(),
                _buildMdp(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: connecte,
                      onChanged: (bool? value) {
                        setState(() {
                          connecte = value!;
                        });
                      },
                      checkColor: Colors.white,
                    ),
                    Text(
                      'Rester Connecté ?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    await LoginScreen();
                  },
                  child: Text(
                    'Se Connecter',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                ),
                SizedBox(height: 10),
                Text(
                  'OU',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new FormScreen()));
                  },
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                ),
                SizedBox(height: 10),
                RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: 'Mot de passe oublié ?',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new send_email()));
                        },
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
