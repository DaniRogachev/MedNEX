import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser{
  final String uid;
  final String email;
  

  FirebaseUser(this.email, { required this.uid });
}

class DatabaseUser{
  late final String uid;
  late final String name;
  late final bool isDoctor;
  late final String? middleName;
  late final String? surname;
  late final List<String>? medicalSpecialties;
  late final List<String>? titles;
  late final int? experience;
  late final String? city;
  late final String? docUin;
  late final String? price;
  late final int rating;
  late final int rates;
  late final int balance;

  DatabaseUser(
      this.uid,
      this.name,
      this.isDoctor,
      this.middleName,
      this.surname,
      this.medicalSpecialties,
      this.titles,
      this.experience,
      this.city,
      this.docUin,
      this.price,
      this.rating,
      this.rates,
      this.balance);

  DatabaseUser.fromSnapshot(DocumentSnapshot snapshot, this.uid){
    name = snapshot["username"];
    isDoctor = snapshot["isDoctor"];
    middleName = snapshot["middleName"];
    surname = snapshot["surname"];
    if(snapshot["medicalSpecialties"]!=null) {
      medicalSpecialties = snapshot["medicalSpecialties"].cast<String>();
    }else{
      medicalSpecialties = null;
    }
    if(snapshot["titles"] != null) {
      titles = snapshot["titles"].cast<String>();
    }else{
      titles = null;
    }
    experience = snapshot["experience"];
    city = snapshot["city"];
    docUin = snapshot["docUin"];
    price = snapshot["price"];
    rating = snapshot["rating"];
    rates = snapshot["rates"];
    balance = snapshot["balance"];
  }
}