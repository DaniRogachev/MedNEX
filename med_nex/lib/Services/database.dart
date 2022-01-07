import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future addUser(String uid, String username, String? middleName, String? surname, bool isDoctor, String? medicalSpecialty, int? experience, String? city, String? docUin, String? price) async {
    return users.doc(uid).set({
      'username': username,
      'middleName': middleName,
      'surname': surname,
      'isDoctor': isDoctor,
      'medicalSpecialty': medicalSpecialty,
      'experience': experience,
      'city': city,
      'docUin': docUin,
      'price': price,
      'rating': 0,
      'rates': 0
    });
  }
}