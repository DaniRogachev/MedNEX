import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Models/user.dart';

class DatabaseService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference requests = FirebaseFirestore.instance.collection('requests');


  Future addUser(String uid, String username, String? middleName, String? surname, bool isDoctor, int? experience, String? city, String? docUin, String? price, List<String>? titles, List<String>? medSpecialties) async {
    return users.doc(uid).set({
      'username': username,
      'middleName': middleName,
      'surname': surname,
      'isDoctor': isDoctor,
      'medicalSpecialties': medSpecialties,
      'titles': titles,
      'experience': experience,
      'city': city,
      'docUin': docUin,
      'price': price,
      'rating': 0,
      'rates': 0,
      'balance': 0,
    });
  }

  Future addRequest(String title, String description, DatabaseUser patient, DatabaseUser doctor){
    updateBalance(patient.uid, -int.parse(doctor.price!));
    return requests.doc(requests.doc().id).set({
      'user_id': patient.uid,
      'doc_id': doctor.uid,
      'title': title,
      'description': description,
      'status': "requested"
    });
  }

  Future<DocumentSnapshot> getCurrUser(String uid) async{
    return await users.doc(uid).get();
  }

  Stream<QuerySnapshot> get allUsers{
    return users.snapshots();
  }

  Stream<QuerySnapshot> get allRequests{
    return requests.snapshots();
  }

  Future acceptRequest(String uid, DatabaseUser doctor){
    updateBalance(doctor.uid, int.parse(doctor.price!));
    return requests.doc(uid).update({'status':"accepted"}).then((value) => print("Request Accepted"))
        .catchError((error) => print("Failed to accept request: $error"));
  }

  Future cancelRequest(String uid){
    return requests.doc(uid).update({'status':'cancelled'}).then((value) => print("Request cancelled"))
        .catchError((error) => print("Failed to cancel request: $error"));
  }

  Future updateBalance(String uid, int deposit){
    return users.doc(uid).update({'balance':FieldValue.increment(deposit)}).then((value) => print("Balance Updated"))
        .catchError((error) => print("Failed to update balance: $error"));
  }

  // Future depositAmount(){
  //
  // }
}