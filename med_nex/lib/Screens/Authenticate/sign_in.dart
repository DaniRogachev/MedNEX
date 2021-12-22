import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleToRegister;

  SignIn({required this.toggleToRegister});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[100],
        elevation: 0.0,
        title: Text('Sign in', style: TextStyle(
          color: Colors.cyanAccent[700],
        ))
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val){
                  if(val!=null && val.isEmpty){
                    return "Enter an email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email'
                ),
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val){
                  if(val!=null && val.isEmpty){
                    return "Enter a password";
                  }
                  else if(val != null && val.length<8){
                    return "The password must be at least 8 characters";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password'
                ),
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    RegularUser? user = await _authService.emailSignIn(email, password);
                    if(user==null){
                      print('There is an error');
                    }else{
                      print('Successful');
                    }
                  }else{
                    print("There is something which is not working");
                  }
                },
                child: Text(
                  'Sign in'
                ),
              ),
              TextButton(
                  onPressed: (){
                    widget.toggleToRegister();
                  },
                  child: Text(
                    "Don't have an account? Register here!"
                  )
              )
            ]
          ),
        ),
      ),
    );
  }
}
