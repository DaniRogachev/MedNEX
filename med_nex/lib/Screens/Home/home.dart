import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('MedNEX', style: TextStyle(
            color: Colors.cyanAccent[700],
          ), textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            OutlinedButton.icon(onPressed: () async{
              await _auth.signOut();
            }, icon: Icon(Icons.logout), label: Text(''))
          ]
      ),
    );
  }
}
