import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';


class Request extends StatefulWidget {
  final DatabaseUser doctor;
  final String uid;

  const Request({Key? key, required this.doctor, required this.uid}) : super(key: key);


  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text("Request Consultation",
              style: TextStyle(
                color: Colors.cyanAccent[700],
              ))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10.0),
              TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a title";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Title'),
                onChanged: (val) {
                  setState(() => title = val);
                }),
              const SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 8,
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a description";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description'),
                onChanged: (val) {
                  setState(() => description = val);
                }),
              Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Back")),
                    OutlinedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){
                          await _databaseService.addRequest(title, description, widget.uid, widget.doctor.uid);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Request'),
                    ),
                  ]
              )
            ]
          ),
        )
      )
    );
  }
}
