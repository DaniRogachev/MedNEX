import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/doctor_field.dart';

class DoctorList extends StatefulWidget {
  final String uid;

  const DoctorList({Key? key, required this.filters, required this.uid}) : super(key: key);

  final Map? filters;

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {

  bool checkDoctor(DatabaseUser doc){
    if(widget.filters!.containsKey("Price")){
      if(int.parse(doc.price!) > int.parse(widget.filters!["Price"])){
        return false;
      }
    }
    if(widget.filters!.containsKey("City")){
      if(doc.city != widget.filters!["City"]){
        return false;
      }
    }
    if(widget.filters!.containsKey("medicalSpecialties")){
      if(!doc.medicalSpecialties!.toSet().containsAll(widget.filters!["medicalSpecialties"])){
        return false;
      }
    }
    return true;
  }

  List<DatabaseUser> filterDocList(List<DatabaseUser> doctors){
    List<DatabaseUser> result = [];
    if(widget.filters!.isEmpty){
      return doctors;
    }
    else{
      for(var doc in doctors){
        if(checkDoctor(doc)){
          result.add(doc);
        }
      }
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {
    print("Fitlers empty?");
    print(widget.filters!.isEmpty);
    var currDocCount = 0;
    var maxDocCount = 20;
    final allUsers = Provider.of<QuerySnapshot?>(context);
    List<DatabaseUser> doctors = [];
    List<DatabaseUser> filteredDoctors = [];
    if(allUsers != null){
      for(var doc in allUsers.docs){
        Map? userData = doc.data() as Map?;
        if(userData!["isDoctor"] && currDocCount<maxDocCount){
          print(userData);
          print("up here");
          doctors.add(DatabaseUser(doc.id, userData["username"], userData["isDoctor"], userData["middleName"], userData["surname"], userData["medicalSpecialties"].cast<String>(), userData["titles"].cast<String>(), userData["experience"], userData["city"], userData["docUin"], userData["price"], userData["rating"], userData["rates"], userData["balance"]));
          currDocCount++;
        }
      }

      filteredDoctors = filterDocList(doctors);
      print(doctors.toString());
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: filteredDoctors.length,
      itemBuilder: (BuildContext context, int index) {
        return DoctorField(user: filteredDoctors[index], currUserId: widget.uid);
      },
    );
  }
}
