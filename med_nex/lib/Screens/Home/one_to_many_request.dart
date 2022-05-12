import 'package:flutter/material.dart';
import 'package:med_nex/Models/medical_specialty.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/database.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class OneToManyRequest extends StatefulWidget {
  final DatabaseUser user;

  const OneToManyRequest({Key? key, required this.user}) : super(key: key);

  @override
  _OneToManyRequestState createState() => _OneToManyRequestState();
}

class _OneToManyRequestState extends State<OneToManyRequest> {
  final _formKey = GlobalKey<FormState>();

  static List<MedSpecialty> medSpecialties = [
    MedSpecialty(name: "Accident and Emergency Medicine"),
    MedSpecialty(name: "Allergist"),
    MedSpecialty(name: "Anaesthetics"),
    MedSpecialty(name: "Cardiology"),
    MedSpecialty(name: "Child Psychiatry"),
    MedSpecialty(name: "Clinical Biology"),
    MedSpecialty(name: "Clinical Chemistry"),
    MedSpecialty(name: "Clinical Microbiology"),
    MedSpecialty(name: "Clinical Neurophysiology"),
    MedSpecialty(name: "Craniofacial Surgery"),
    MedSpecialty(name: "Dermatology"),
    MedSpecialty(name: "Endocrinology"),
    MedSpecialty(name: "Family and General Medicine"),
    MedSpecialty(name: "Gastroenterologic Surgery"),
    MedSpecialty(name: "Gastroenterology"),
    MedSpecialty(name: "General Practice"),
    MedSpecialty(name: "General Surgery"),
    MedSpecialty(name: "Geriatrics"),
    MedSpecialty(name: "Hematology"),
    MedSpecialty(name: "Immunology"),
    MedSpecialty(name: "Infectious Diseases"),
    MedSpecialty(name: "Internal Medicine"),
    MedSpecialty(name: "Laboratory Medicine"),
    MedSpecialty(name: "Nephrology"),
    MedSpecialty(name: "Neuropsychiatry"),
    MedSpecialty(name: "Neurology"),
    MedSpecialty(name: "Neurosurgery"),
    MedSpecialty(name: "Nuclear Medicine"),
    MedSpecialty(name: "Obstetrics and Gynaecology"),
    MedSpecialty(name: "Occupational Medicine"),
    MedSpecialty(name: "Oncology"),
    MedSpecialty(name: "Ophthalmology"),
    MedSpecialty(name: "Oral and Maxillofacial Surgery"),
    MedSpecialty(name: "Orthopaedics"),
    MedSpecialty(name: "Otorhinolaryngology"),
    MedSpecialty(name: "Paediatric Surgery"),
    MedSpecialty(name: "Paediatrics"),
    MedSpecialty(name: "Pathology"),
    MedSpecialty(name: "Pharmacology"),
    MedSpecialty(name: "Physical Medicine and Rehabilitation"),
    MedSpecialty(name: "Plastic Surgery"),
    MedSpecialty(name: "Podiatric Surgery"),
    MedSpecialty(name: "Preventive Medicine"),
    MedSpecialty(name: "Psychiatry"),
    MedSpecialty(name: "Public Health"),
    MedSpecialty(name: "Radiation Oncology"),
    MedSpecialty(name: "Radiology"),
    MedSpecialty(name: "Respiratory Medicine"),
    MedSpecialty(name: "Rheumatology"),
    MedSpecialty(name: "Stomatology"),
    MedSpecialty(name: "Thoracic Surgery"),
    MedSpecialty(name: "Tropical Medicine"),
    MedSpecialty(name: "Urology"),
    MedSpecialty(name: "Vascular Surgery"),
    MedSpecialty(name: "Venereology")
  ];

  final specialties = medSpecialties
      .map((medSpecialty) => MultiSelectItem<MedSpecialty?>(medSpecialty, medSpecialty.name))
      .toList();

  late String title;
  late String description;
  double price = 10;
  List<MedSpecialty?> selectedSpecialties = [];


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
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 20.0),
                  MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      items: specialties,
                      title: const Text("Titles"),
                      buttonIcon: const Icon(
                          Icons.add
                      ),
                      buttonText: const Text("Titles"),
                      onConfirm: (val){
                        selectedSpecialties = val as List<MedSpecialty?>;                      }
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: price,
                    max: 100,
                    divisions: 100,
                    label: price.round().toString(),
                    onChanged: (double value) {
                      setState((){
                        price = value;
                      });
                    },

                  ),
                  const SizedBox(height: 20.0),
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
                              if(widget.user.balance >= price){
                                await DatabaseService().addOneToManyRequest(title, description, selectedSpecialties.map((medSpecialty) => medSpecialty!.name).toList(), price.toInt(), widget.user);
                                Navigator.pop(context);
                              }
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
