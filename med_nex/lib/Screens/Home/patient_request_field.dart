import 'package:flutter/material.dart';
import 'package:med_nex/Models/consultation_request.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';

class PatientRequestField extends StatelessWidget {
  final ConsultationRequest request;


  const PatientRequestField({Key? key, required this.request}) : super(key: key);

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
                    await DatabaseService().cancelRequest(request.requestId);
                  },
                  icon: const Icon(Icons.clear),
                ),
            )
        )
    );
  }
}