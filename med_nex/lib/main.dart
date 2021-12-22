import 'package:flutter/material.dart';
import 'package:med_nex/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<RegularUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
