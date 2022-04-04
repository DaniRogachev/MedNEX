import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/request_to_many.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/patient_request_field.dart';
import 'package:med_nex/Screens/Home/patient_request_to_many_field.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Services/database.dart';


class PatientRequestsToMany extends StatefulWidget {
  final DatabaseUser currUser;

  const PatientRequestsToMany({Key? key, required this.currUser}) : super(key: key);

  @override
  _PatientRequestsToManyState createState() => _PatientRequestsToManyState();
}

class _PatientRequestsToManyState extends State<PatientRequestsToMany> {
  @override
  Widget build(BuildContext context) {
    final allRequests = Provider.of<QuerySnapshot?>(context);
    List<RequestToMany> requests = [];
    if (allRequests != null) {
      for (var request in allRequests.docs) {
        Map? requestData = request.data() as Map?;
        if (requestData!["patient_id"] == widget.currUser.uid &&
            requestData["status"] != "cancelled") {
          requests.add(RequestToMany.withNoPatient(
              request.id,
              requestData['title'],
              requestData['description'],
              requestData['medicalSpecialties'].cast<String>(),
              requestData['price'],
              null,
              requestData['status']));
          print('done');
        }
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        return PatientRequestToManyField(request: requests[index]);
      },
    );
  }
}
