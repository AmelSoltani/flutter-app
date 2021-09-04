import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class NouveauMdp extends StatefulWidget {
  final String value;
  NouveauMdp({Key? key, required this.value}) : super(key: key);
  @override
  _NouveauMdpState createState() => _NouveauMdpState();
}

class _NouveauMdpState extends State<NouveauMdp> {
  late String _mdp1;
  late String _mdp2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incendie',
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Entrer votre nouveau mot de passe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Mot de passe'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrer le Mot de passe';
                        }
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _mdp1 = value;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Confirmer le Mot de passe'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champs est obligatoire';
                        }
                      },
                      onSaved: (value) {
                        if (value != null) {
                          _mdp2 = value;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          print(_mdp1);
                          print(_mdp2);

                          if (_mdp1 == _mdp2) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new LoginScreen()));
                          }
                        },
                        child: Text(
                          'Valider',
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
