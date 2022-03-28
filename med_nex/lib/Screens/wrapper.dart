import 'package:flutter/material.dart';
import 'package:med_nex/Screens/Home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Screens/Home/home_wrapper.dart';

import 'Authenticate/sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser?>(context);
    if(user == null){
      return const Authenticate();
    }
    else{
      return HomeWrapper(uid: user.uid,);
    }
  }
}
