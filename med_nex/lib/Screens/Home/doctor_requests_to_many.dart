import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/consultation_request.dart';
import 'package:med_nex/Models/request_to_many.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/loading.dart';
import 'package:med_nex/Screens/Home/request_to_many_field.dart';
import 'package:provider/provider.dart';

class DoctorRequestsToMany extends StatefulWidget {
  final DatabaseUser doctor;

  const DoctorRequestsToMany({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorRequestsToManyState createState() => _DoctorRequestsToManyState();
}

class _DoctorRequestsToManyState extends State<DoctorRequestsToMany> {
  bool checkRequest(List<String> requestedSpecialties){
    for(var specialty in requestedSpecialties){
      if(widget.doctor.medicalSpecialties!.contains(specialty)){
        return true;
      }
    }
    return false;
  }

  Future<List<DatabaseUser>> getPatients(List<DocumentReference> patients) async {
    List<DatabaseUser> results = [];
    for(var patient in patients){
      await patient.get().then((value){
        results.add(DatabaseUser.fromSnapshot(value, value.id));
      });
    }
    results.forEach((element) {print(element.name);});
    return results;
  }


  @override
  Widget build(BuildContext context) {
    final allRequests = Provider.of<QuerySnapshot?>(context);
    List<RequestToMany> requests = [];
    List<DocumentReference> patients = [];
    if(allRequests != null){
      print("Checkpoint 1");
      for(var request in allRequests.docs){
        Map? requestData = request.data() as Map?;
        if(checkRequest(requestData!["medicalSpecialties"].cast<String>()) && requestData["status"] == "requested"){
          patients.add(requestData['patient']);
          requests.add(RequestToMany.withNoPatient(request.id, requestData['title'], requestData['description'], requestData['medicalSpecialties'].cast<String>(), requestData['price'], null, requestData['status']));
        }
      }
    }

    return FutureBuilder(
      future: getPatients(patients),
      builder: (BuildContext context, AsyncSnapshot<List<DatabaseUser>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Text("Currently there are not requests");
        }

        int index = 0;

        if (snapshot.connectionState == ConnectionState.done){
          requests.forEach((element) {
            element.patient = snapshot.data!.elementAt(index);
            index++;
          });
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              return RequestToManyField(request: requests[index], doctor: widget.doctor,);
            },
          );
        }else{
          return const Loading();
        }
      },
    );

  }
}
