import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Authenticate/register_doc.dart';
import 'package:med_nex/Services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleToSignIn;

  const Register({Key? key, required this.toggleToSignIn}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  _nextFocus(FocusNode focusNode){
    FocusScope.of(context).requestFocus(focusNode);
  }

  late String email;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('Sign up', style: TextStyle(
            color: Colors.cyanAccent[700],
          ))
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter an email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_usernameFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email'
                    ),
                    onChanged: (val){
                      setState(() => email = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter an username";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _usernameFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_passwordFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Username'
                    ),
                    onChanged: (val){
                      setState(() => username = val);
                    }
                ),
                const SizedBox(height: 20.0),
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
                    focusNode: _passwordFocusNode,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password'
                    ),
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    }
                ),
                const SizedBox(height: 20.0),
                OutlinedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      FirebaseUser? user = await _authService.patientRegister(email, username, password);
                      if(user==null){
                        print('There is an error');
                      }else{
                        print('Successful');
                      }
                    }else{
                      print("There is something which is not working");
                    }
                  },
                  child: const Text(
                      'Register'
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterDoc()),
                    );
                  },
                  child: const Text(
                    "Are you a doctor? Sign up as such!"
                  )
                ),
                TextButton(
                    onPressed: (){
                      widget.toggleToSignIn();
                    },
                    child: const Text(
                        "Already have an account? Sign in here!"
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
