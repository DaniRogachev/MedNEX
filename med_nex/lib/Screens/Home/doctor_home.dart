import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Chat/chats_list.dart';
import 'package:med_nex/Screens/Home/doctor_requests_to_many.dart';
import 'package:med_nex/Screens/Settings/doctor_settings.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Screens/Home/doctor_requests.dart';

class DoctorHome extends StatefulWidget {
  final String uid;
  final DatabaseUser doctor;

  const DoctorHome({Key? key, required this.uid, required this.doctor}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final AuthService _auth = AuthService();

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> options = <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: DoctorRequests(uid: widget.uid, doctor: widget.doctor,),
      ),
      StreamProvider<QuerySnapshot?>.value(
        value: DatabaseService().allRequestsToMany,
        initialData: null,
        child: DoctorRequestsToMany(doctor: widget.doctor,)
      ),
      StreamProvider<QuerySnapshot?>.value(
          value: DatabaseService().allChats,
          initialData: null,
          child: SingleChildScrollView(
              child: ChatsList(currUser: widget.doctor,)
          )
      ),
      DoctorSettings(currUser: widget.doctor)
    ];

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
              }, icon: const Icon(Icons.logout), label: const Text(''))
            ]
        ),
        body: SingleChildScrollView(
          child: options.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.approval),
              label: 'My Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_motion),
              label: 'All Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.cyan[100],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
