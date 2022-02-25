import 'package:flutter/material.dart';
import 'package:med_nex/Models/request_to_many.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';

class RequestToManyField extends StatelessWidget {
  final RequestToMany request;
  final DatabaseUser doctor;

  const RequestToManyField({Key? key, required this.request, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
            child: ListTile(
                //leading: Text(request.patient.name),
                leading: Text(request.price.toString()),
                title: Text(request.title),
                subtitle: Text(request.patient.name),
                trailing: OutlinedButton(
                  onPressed: () async {
                    await DatabaseService().acceptRequestToMany(request, doctor);
                  },
                  child: const Text("Accept"),
                )
            )
        )
    );
  }
}
