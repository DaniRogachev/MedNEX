import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/consultation_request.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/request_field.dart';
import 'package:provider/provider.dart';

class DoctorRequests extends StatefulWidget {
  final String uid;
  final DatabaseUser doctor;
  const DoctorRequests({Key? key, required this.uid, required this.doctor}) : super(key: key);

  @override
  _DoctorRequestsState createState() => _DoctorRequestsState();
}

class _DoctorRequestsState extends State<DoctorRequests> {
  @override
  Widget build(BuildContext context) {
    print("in doctor requests");
    final allRequests = Provider.of<QuerySnapshot?>(context);
    List<ConsultationRequest> requests = [];
    if(allRequests != null){
      print("Checkpoint 1");
      for(var request in allRequests.docs){
        Map? requestData = request.data() as Map?;
        if(requestData!["doc_id"] == widget.uid && requestData["status"] == "requested"){
          requests.add(ConsultationRequest(requestData["title"], requestData["description"], requestData["status"], requestData["user_id"], requestData["doc_id"], request.id));
        }
      }
    }
    print(requests.length);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        return RequestField(request: requests[index], doctor: widget.doctor,);
      },
    );
  }
}
