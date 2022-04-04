import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';

class PatientSettings extends StatefulWidget {
  final DatabaseUser currUser;

  const PatientSettings({Key? key, required this.currUser}) : super(key: key);

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  @override
  Widget build(BuildContext context) {
    final email = Provider.of<FirebaseUser?>(context)!.email;

    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    TextEditingController controller = TextEditingController();
                    String username = "";
                    return AlertDialog(
                      title: const Text("Edit Username"),
                      content: TextField(
                        controller: controller,
                          decoration: const InputDecoration(
                              hintText: 'New Username'),
                          onChanged: (val) async{
                            setState(() => username = val);
                          }),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              if(username.isNotEmpty) {
                                DatabaseService().updateUsername(
                                    widget.currUser.uid, username);
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Set Username')
                        )
                      ],
                      );
                  }
              );
            },
            child: const Text("Edit username"),
            style: ElevatedButton.styleFrom(
              primary: Colors.tealAccent,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              textStyle: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              AuthService().resetPassword(email);
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Change password"),
                      content: Text("An email was send to " + email),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK')
                        )
                      ],
                    );
                  }
              );
            },
            child: const Text("Edit password"),
            style: ElevatedButton.styleFrom(
              primary: Colors.tealAccent,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              textStyle: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Delete Account"),
                      content: const Text("Are you sure you want to delete this account"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              AuthService().deleteAccount();
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')
                        )
                      ],
                    );
                  }
              );
            },
            child: const Text("Delete account"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              textStyle: const TextStyle(fontSize: 15),
            ),
          )
        ],
      )
    );
  }
}
