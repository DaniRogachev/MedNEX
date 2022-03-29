import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Models/chat.dart';
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

  Future addOneToManyRequest(String title, String description,
      List<String> medSpecialties, int price, DatabaseUser patient){
    updateBalance(patient.uid, -price);
    return requestsToMany.doc(requestsToMany.doc().id).set({
      'patient': users.doc(patient.uid),
      'patient_id': patient.uid,
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
      'request': requestId,
      'lastMessage': doctorName + ' has accepted your request',
      'lastMessageTime': Timestamp.now(),
      'status': 'active',
      'isRated': false
    });
  }
  
  Future createMessage(String message, DatabaseUser sender, Chat chat){
    final CollectionReference messages = FirebaseFirestore.instance
        .collection('chats/' + chat.chatId + '/messages');
    Timestamp currTime = Timestamp.now();
    chats.doc(chat.chatId).update({
      'lastMessage': message,
      'lastMessageTime': currTime
    });
    return messages.doc(messages.doc().id).set({
      'senderId': sender.uid,
      'senderName': sender.name,
      'message': message,
      'time': currTime
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

  Stream<QuerySnapshot> get allChats{
    return chats.orderBy('lastMessageTime', descending: true).snapshots();
  }

  Stream<QuerySnapshot> chatMessages(Chat chat){
    final CollectionReference messages = FirebaseFirestore.instance
        .collection('chats/' + chat.chatId + '/messages');
    return messages.orderBy('time').snapshots();
  }

  Future updateUsername(String uid, String username){
    return users.doc(uid).
    update({'username':username}).then((value) => print("Username Updated"))
        .catchError((error) => print("Failed to update username: $error"));
  }

  Future updatePrice(String uid, String price){
    return users.doc(uid).update({'price':price})
        .then((value) => print("Price Updated"))
        .catchError((error) => print("Failed to update price: $error"));
  }

  Future acceptRequest(String uid, DatabaseUser doctor, DatabaseUser patient){
    updateBalance(doctor.uid, int.parse(doctor.price!));
    createChatRoom(patient.uid, doctor.uid, patient.name, doctor.name, uid);
    return requests.doc(uid).update({'status':"accepted"}).
    then((value) => print("Request Accepted"))
        .catchError((error) => print("Failed to accept request: $error"));
  }

  Future acceptRequestToMany(RequestToMany request, DatabaseUser doctor){
    updateBalance(doctor.uid, request.price);
    createChatRoom(
        request.patient.uid, doctor.uid, request.patient.name, doctor.name, request.uid);
    return requestsToMany.doc(request.uid).update({
      'status':"accepted",
      'doctor': users.doc(doctor.uid)
    }).then((value) => print("Request Accepted")).
    catchError((error) => print("Failed to accept request: $error"));
  }

  Future cancelRequest(String uid){
    return requests.doc(uid).update({'status':'cancelled'}).then((value) => print("Request cancelled"))
        .catchError((error) => print("Failed to cancel request: $error"));
  }

  Future cancelRequestToMany(String uid){
    return requestsToMany.doc(uid).update({'status':'cancelled'}).then((value) => print("Request cancelled"))
        .catchError((error) => print("Failed to cancel request: $error"));
  }

  Future updateBalance(String uid, int deposit){
    return users.doc(uid).update({'balance':FieldValue.increment(deposit)})
        .then((value) => print("Balance Updated"))
        .catchError((error) => print("Failed to update balance: $error"));
  }

  Future finishConsultation(Chat chat){
    return chats.doc(chat.chatId).update({
      'status':'finished'
    }).then((value) => print('Consultation finished'))
        .catchError((error) => print('Failed to finish consultation'));
  }

  Future updateRating(String docUid, int rate, String chatId){
    chats.doc(chatId).update({
      'isRated': true,
    });
    return users.doc(docUid).update({
      'rating':FieldValue.increment(rate),
      'rates': FieldValue.increment(1)
    }).then((value) => print('Rated'))
        .catchError((error) => print('Failed to rate'));
  }

  // Future depositAmount(){
  //
  // }
}