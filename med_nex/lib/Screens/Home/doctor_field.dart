import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/doctor_info.dart';

class DoctorField extends StatelessWidget {
  final DatabaseUser doctor;
  final DatabaseUser patient;
  //final String currUserId;
  const DoctorField({Key? key, required this.doctor, required this.patient}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Text(doctor.rating.toString() + " (" + doctor.rates.toString() + ")"),
          title: Text(doctor.name + " " + doctor.surname!),
          subtitle: Text(doctor.medicalSpecialties.toString()),
          trailing: Text(doctor.price! + " leva"),
          onTap: () async{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorInfo(doctor: doctor, patient: patient,)),
            );
          },
        )
      )
    );
  }
}
