import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Screens/Home/doctor_requests.dart';

class DoctorHome extends StatefulWidget {
  final String uid;

  const DoctorHome({Key? key, required this.uid}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    print("in doctor home");
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().allRequests,
      initialData: null,
      child: Scaffold(
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
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: DoctorRequests(uid: widget.uid)
        )
      ),
    );
  }
}
