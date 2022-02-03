import 'package:med_nex/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_nex/Services/database.dart';
import 'package:med_nex/Models/title.dart';
import 'package:med_nex/Models/medical_specialty.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  FirebaseUser? _getFirebaseUser(User? user){
    return user != null ? FirebaseUser(user.email.toString(), uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user{
    return _auth.authStateChanges().map(_getFirebaseUser);
  }

  Future emailRegister(String email, String username, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService().addUser(user!.uid, username, null, null, false, null, null, null, null, null, null);
      return _getFirebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future doctorRegister(String email, String username, String middleName, String surname, String password, String experience, String city, String docUin, String price, List<MedTitle?> titles, List<MedSpecialty?> medSpecialties) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService().addUser(user!.uid, username, middleName, surname, true, int.parse(experience), city, docUin, price, titles.map((title) => title!.name).toList(), medSpecialties.map((medSpecialty) => medSpecialty!.name).toList());
      return _getFirebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future emailSignIn(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _getFirebaseUser(user);
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

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}