import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/request.dart';

class DoctorInfo extends StatelessWidget {
  final DatabaseUser user;
  final String currUserId;
  const DoctorInfo({Key? key, required this.user, required this.currUserId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text("D-r " + user.name + " " + user.surname!,
              style: TextStyle(
                color: Colors.cyanAccent[700],
              ))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text("Full name: " + user.name + " " + user.middleName! + " " + user.surname!),
            const SizedBox(height: 10.0),
            Text("Medical specialties: " + user.medicalSpecialties.toString()),
            const SizedBox(height: 10.0),
            Text("Titles: " + user.titles.toString()),
            const SizedBox(height: 10.0),
            Text("Experience: " + user.experience.toString()),
            const SizedBox(height: 10.0),
            Text("Region: " + user.city!),
            const SizedBox(height: 10.0),
            Text("Price (in leva): " + user.price!),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back")),
                OutlinedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Request(doctor: user, uid: currUserId)),
                    );
                  },
                  child: const Text('Request Consultation'),
                ),
              ]
            )
          ]
        )
      )
    );
  }
}
