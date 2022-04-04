import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:med_nex/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:med_nex/Models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51KajgsJGy4DwuvbqMM4gNCRTYA2uBM5Jcm5d5Bh20sTjjsol5BnMkHvVbN1JtUaarnh4qsZwW0RBNsu8hFvjR3Ua002nq3cDAq';
  runApp(const MedNex());
}

class MedNex extends StatelessWidget {
  const MedNex({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
