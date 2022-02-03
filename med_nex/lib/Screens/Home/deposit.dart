import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  late int depositAmount;


  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<FirebaseUser?>(context)!.uid;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('MedNEX', style: TextStyle(
            color: Colors.cyanAccent[700],
          ), textAlign: TextAlign.center,
          ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Amount'
                    ),
                    onChanged: (val){
                      setState(() => depositAmount = int.parse(val));
                    }
                ),
                const SizedBox(height: 20.0),
                OutlinedButton(
                    onPressed: () async {
                      await DatabaseService().updateBalance(uid, depositAmount);
                    },
                    child: const Text("Deposit")
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back")),
              ]
            ),
        )
      )
    );
  }
}
