import 'package:flutter/material.dart';
import 'package:med_nex/Models/request_to_many.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';

class PatientRequestToManyField extends StatelessWidget {
  final RequestToMany request;


  const PatientRequestToManyField({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
            child: ListTile(
              leading: Text(request.status),
              title: Text(request.title),
              subtitle: Text(request.description),
              trailing: IconButton(
                onPressed: () async {
                  DatabaseService().cancelRequestToMany(request.uid);
                },
                icon: const Icon(Icons.clear),
              ),
            )
        )
    );
  }
}