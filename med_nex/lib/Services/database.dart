import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');


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
    });
  }
}