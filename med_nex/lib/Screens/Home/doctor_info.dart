import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/request.dart';

class DoctorInfo extends StatelessWidget {
  final DatabaseUser doctor;
  final DatabaseUser patient;
  //final String currUserId;
  const DoctorInfo({Key? key, required this.doctor, required this.patient}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text("D-r " + doctor.name + " " + doctor.surname!,
              style: TextStyle(
                color: Colors.cyanAccent[700],
              ))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text("Full name: " + doctor.name + " " + doctor.middleName! + " " + doctor.surname!),
            const SizedBox(height: 10.0),
            Text("Medical specialties: " + doctor.medicalSpecialties.toString()),
            const SizedBox(height: 10.0),
            Text("Titles: " + doctor.titles.toString()),
            const SizedBox(height: 10.0),
            Text("Experience: " + doctor.experience.toString()),
            const SizedBox(height: 10.0),
            Text("Region: " + doctor.city!),
            const SizedBox(height: 10.0),
            Text("Price (in leva): " + doctor.price!),
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
                      MaterialPageRoute(builder: (context) => Request(doctor: doctor, patient: patient,)),
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
