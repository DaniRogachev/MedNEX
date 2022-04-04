import 'package:med_nex/Models/user.dart';

class RequestToMany{
  late final String uid;
  late final String title;
  late final String description;
  late final List<String> medicalSpecialties;
  late final int price;
  late final DatabaseUser patient;
  late final DatabaseUser? doctor;
  late final String status;


  RequestToMany(this.uid, this.title, this.description, this.medicalSpecialties,
      this.price, this.patient, this.doctor, this.status);


  RequestToMany.withNoPatient(this.uid, this.title, this.description, this.medicalSpecialties,
      this.price, this.doctor, this.status);
}