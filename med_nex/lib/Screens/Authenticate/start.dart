import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  final Function toggleToRegister;
  final Function toggleToSignIn;

  Start({required this.toggleToRegister, required this.toggleToSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
            backgroundColor: Colors.tealAccent[100],
            elevation: 0.0,
            title: Text('MedNEX', style: TextStyle(
              color: Colors.cyanAccent[700],
            ))
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    this.toggleToRegister();
                  },
                  child: Text(
                      "Register"
                  )
              ),
              ElevatedButton(
                  onPressed: (){
                    this.toggleToSignIn();
                  },
                  child: Text(
                      "Sign in"
                  )
              ),
            ]
          )
        )
    );
  }
}
