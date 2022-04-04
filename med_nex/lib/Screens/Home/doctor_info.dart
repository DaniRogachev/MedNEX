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
            const SizedBox(height: 15.0),
            const Text("Full name", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.name + " " + doctor.middleName! + " " + doctor.surname!, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
            const Text("Medical specialties", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.medicalSpecialties.toString(), style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
            const Text("Titles", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.titles.toString(), style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
            const Text("Experience", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.experience.toString() + " years", style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
            const Text("Region", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.city!, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
            const Text("Price", style: TextStyle(fontSize: 15.5, color: Colors.teal)),
            Text(doctor.price!, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: Colors.teal)),
            const SizedBox(height: 15.0),
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
