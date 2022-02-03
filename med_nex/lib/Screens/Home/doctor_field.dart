import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';

class DoctorField extends StatelessWidget {
  final DatabaseUser user;
  const DoctorField({Key? key, required this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(user.name + " " + user.surname!),
          subtitle: Text(user.medicalSpecialties.toString()),
          trailing: Text(user.price! + " leva"),
        )
      )
    );
  }
}
