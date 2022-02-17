import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Screens/Home/doctor_home.dart';
import 'package:med_nex/Services/database.dart';
import 'package:med_nex/Models/user.dart';

import 'home.dart';

class HomeWrapper extends StatefulWidget {
  final String uid;


  const HomeWrapper({Key? key, required this.uid, }) : super(key: key);


  static final DatabaseService databaseService = DatabaseService();

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: HomeWrapper.databaseService.getCurrUser(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done){
          DatabaseUser currUser = DatabaseUser.fromSnapshot(snapshot.data!, widget.uid);
          if(currUser.isDoctor){
            return DoctorHome(uid: widget.uid, doctor: currUser,);
          }
          else {
            return Home(currUser: currUser);
          }
        }else {
          return const Text("Something went wrong");
        }
      },

    );
  }
}
