import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: Center(
        child: Text(
          'Loading',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.cyanAccent[700],
          ),
        ),
      ),
    );
  }
}
