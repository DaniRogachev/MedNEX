import 'package:med_nex/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  RegularUser? _getRegularUser(User? user){
    return user != null ? RegularUser(user.email.toString(), uid: user.uid) : null;
  }

  Stream<RegularUser?> get user{
    return _auth.authStateChanges().map(_getRegularUser);
  }

  Future emailRegister(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
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