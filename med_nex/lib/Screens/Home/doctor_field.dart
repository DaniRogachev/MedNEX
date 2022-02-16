import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/doctor_info.dart';

class DoctorField extends StatelessWidget {
  final DatabaseUser user;
  final String currUserId;
  const DoctorField({Key? key, required this.user, required this.currUserId}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: OutlinedButton.icon(onPressed: () async{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorInfo(user: user, currUserId: currUserId)),
            );
          }, icon: const Icon(Icons.account_circle), label: const Text('')),
          title: Text(user.name + " " + user.surname!),
          subtitle: Text(user.medicalSpecialties.toString()),
          trailing: Text(user.price! + " leva"),
        )
      )
    );
  }
}
