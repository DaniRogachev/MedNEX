import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';

class Deposit extends StatefulWidget {
  final DatabaseUser currUser;

  const Deposit({Key? key, required this.currUser}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  late int depositAmount;


  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<FirebaseUser?>(context)!.uid;

    return Container(
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
                    widget.currUser.updateBalance(depositAmount);
                  },
                  child: const Text("Deposit")
              ),
            ]
          ),
        )
    );
  }
}
