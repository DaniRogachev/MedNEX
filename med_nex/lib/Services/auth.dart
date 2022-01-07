import 'package:med_nex/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_nex/Services/database.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  RegularUser? _getRegularUser(User? user){
    return user != null ? RegularUser(user.email.toString(), uid: user.uid) : null;
  }

  Stream<RegularUser?> get user{
    return _auth.authStateChanges().map(_getRegularUser);
  }

  Future emailRegister(String email, String username, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService().addUser(user!.uid, username, null, null, false, null, null, null, null, null);
      return _getRegularUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future doctorRegister(String email, String username, String middleName, String surname, String password, String medicalSpecialty, String experience, String city, String docUin, String price) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService().addUser(user!.uid, username, middleName, surname, true, medicalSpecialty, int.parse(experience), city, docUin, price);
      return _getRegularUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future emailSignIn(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _getRegularUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}