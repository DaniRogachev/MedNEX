import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/consultation_request.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/patient_request_field.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Services/database.dart';

class PatientRequests extends StatefulWidget {
  final DatabaseUser currUser;

  const PatientRequests({Key? key, required this.currUser}) : super(key: key);

  @override
  _PatientRequestsState createState() => _PatientRequestsState();
}

class _PatientRequestsState extends State<PatientRequests> {
  @override
  Widget build(BuildContext context) {
    final allRequests = Provider.of<QuerySnapshot?>(context);
    List<ConsultationRequest> requests = [];
    if(allRequests != null){
      for(var request in allRequests.docs){
        Map? requestData = request.data() as Map?;
        if(requestData!["user_id"] == widget.currUser.uid && requestData["status"] != "cancelled"){
          requests.add(ConsultationRequest(requestData["title"], requestData["description"], requestData["status"], requestData["user_id"], requestData["doc_id"], request.id));
        }
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        return PatientRequestField(request: requests[index]);
      },
    );
  }
}
