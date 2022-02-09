import 'package:flutter/material.dart';
import 'package:med_nex/Services/auth.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String email;
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('Reset Password', style: TextStyle(
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
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email'
                  ),
                  onChanged: (val){
                    setState(() => email = val);
                  }
                ),
                const SizedBox(height: 20.0),
                OutlinedButton(
                  child: const Text(
                    'Reset Password'
                  ),
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      await _authService.resetPassword(email);
                      Navigator.pop(context);
                    }
                  },
                )
              ]
          )
        )
      )
    );
  }
}
