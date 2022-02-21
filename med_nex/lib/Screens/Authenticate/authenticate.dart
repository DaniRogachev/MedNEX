import 'package:flutter/material.dart';
import 'package:med_nex/Screens/Authenticate/register.dart';
import 'package:med_nex/Screens/Authenticate/sign_in.dart';
import 'package:med_nex/Screens/Authenticate/start.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool start = true;
  bool showRegister = false;

  void toggleToRegister(){
    setState((){
      start = false;
      showRegister = true;
    });
  }

  void toggleToSignIn(){
    setState((){
      start = false;
      showRegister = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(start){
      return Start(toggleToRegister: toggleToRegister, toggleToSignIn: toggleToSignIn,);
    }
    if(showRegister){
      return Register(toggleToSignIn: toggleToSignIn,);
    }
    return SignIn(toggleToRegister: toggleToRegister,);
  }
}
