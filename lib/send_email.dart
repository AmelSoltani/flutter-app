import 'package:flutter/material.dart';

///import 'package:email_auth/email_auth.dart';
///import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj/LoginScreen.dart';

///import 'RecuperationMdp.dart';

class send_email extends StatefulWidget {
  @override
  _send_emailState createState() => _send_emailState();
}

class _send_emailState extends State<send_email> {
  late String _code;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  ///create a method to send the Emails
  /* void sendOtp() async {
    EmailAuth.sessionName = "Sample";
    var data =
        await EmailAuth.sendOtp(receiverMail: _emailController.value.text);
    if (data != null) {
      AwesomeDialog(
          context: context,
          title: "notification",
          body: Text('un email a eté envoyer , verifiez votre boite email!'))
        ..show();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  new RecuperationMdp(value: _emailController.text)));
    }
  }*/
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Retrouvez votre compte ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                ' Veuillez entrer votre email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _code = value;
                          print(_code);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();
                        await resetPassword(_emailController.value.text);
                      },
                      child: Text(
                        'Envoyer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
