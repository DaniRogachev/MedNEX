import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/consultation_request.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/loading.dart';
import 'package:med_nex/Services/database.dart';

class RequestField extends StatelessWidget {
  final ConsultationRequest request;
  final DatabaseUser doctor;


  const RequestField({Key? key, required this.request, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getCurrUser(request.userId),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot){
        if(snapshot.hasError){
          return Text('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done){
          DatabaseUser patient = DatabaseUser.fromSnapshot(snapshot.data!, snapshot.data!.id);

          return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                  margin: const EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0.0),
                  child: ListTile(
                      leading: Text(request.status),
                      title: Text(request.title),
                      subtitle: Text(patient.name),
                      trailing: OutlinedButton(
                        onPressed: () async {
                          await DatabaseService().acceptRequest(request.requestId, doctor, patient);
                        },
                        child: const Text("Accept"),
                      )
                  )
              )
          );
        }else{
          return const Loading();
        }
      },
    );


  }
}
