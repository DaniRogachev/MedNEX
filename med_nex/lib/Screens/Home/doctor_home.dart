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

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  Widget build(BuildContext context) {
    List<Widget> options = <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: DoctorRequests(uid: widget.uid),
      ),
      const Text("One to many requests"),
      const Text("Chats"),
      const Text("Settings")
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
              }, icon: Icon(Icons.logout), label: Text(''))
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
