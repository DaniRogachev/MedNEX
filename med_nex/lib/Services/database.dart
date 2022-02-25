import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Models/request_to_many.dart';
import 'package:med_nex/Models/user.dart';

class DatabaseService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference requests = FirebaseFirestore.instance.collection('requests');
  final CollectionReference requestsToMany = FirebaseFirestore.instance.collection('request to many');
  final CollectionReference chats = FirebaseFirestore.instance.collection('chats');


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

  Future addOneToManyRequest(String title, String description, List<String> medSpecialties, int price, DatabaseUser patient){
    updateBalance(patient.uid, -price);
    return requestsToMany.doc(requestsToMany.doc().id).set({
      'patient': users.doc(patient.uid),
      'title': title,
      'description': description,
      'medicalSpecialties': medSpecialties,
      'price': price,
      'status': 'requested',
      'doctor': ' '
    });
  }

  Future createChatRoom(String patientId, String doctorId, String patientName, String doctorName, String requestId){
    return chats.doc(chats.doc().id).set({
      'patientId': patientId,
      'doctorId': doctorId,
      'patientName': patientName,
      'doctorName': doctorName,
      'request': requestId
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

  Stream<QuerySnapshot> get allRequestsToMany{
    return requestsToMany.snapshots();
  }

  Future acceptRequest(String uid, DatabaseUser doctor, DatabaseUser patient){
    updateBalance(doctor.uid, int.parse(doctor.price!));
    createChatRoom(patient.uid, doctor.uid, patient.name, doctor.name, uid);
    return requests.doc(uid).update({'status':"accepted"}).then((value) => print("Request Accepted"))
        .catchError((error) => print("Failed to accept request: $error"));
  }

  Future acceptRequestToMany(RequestToMany request, DatabaseUser doctor){
    updateBalance(doctor.uid, request.price);
    createChatRoom(request.patient.uid, doctor.uid, request.patient.name, doctor.name, request.uid);
    return requestsToMany.doc(request.uid).update({
      'status':"accepted",
      'doctor': users.doc(doctor.uid)
    }).then((value) => print("Request Accepted")).catchError((error) => print("Failed to accept request: $error"));

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