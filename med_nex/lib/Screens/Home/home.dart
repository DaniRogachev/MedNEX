import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_nex/Models/medical_specialty.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:med_nex/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_nex/Screens/Home/doctor_list.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:med_nex/Screens/Home/deposit.dart';


class Home extends StatefulWidget {
  final String uid;
  const Home({Key? key, required this.uid}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int selectedIndex = 0;


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

  var filterData = {};

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = <Widget>[
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            OutlinedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Filters"),
                        content: Form(
                          child: Column(
                            children: <Widget>[
                              MultiSelectBottomSheetField(
                                  initialChildSize: 0.4,
                                  listType: MultiSelectListType.CHIP,
                                  searchable: true,
                                  items: specialties,
                                  title: const Text("Medical Specialties"),
                                  buttonIcon: const Icon(
                                      Icons.add
                                  ),
                                  buttonText: const Text("Medical Specialties"),
                                  onConfirm: (val){
                                    filterData['medicalSpecialties'] = val as List<MedSpecialty?>;
                                  }
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'City'
                                ),
                                onChanged: (val) {
                                  if(val.isNotEmpty) {
                                    setState(() => filterData['City'] = val);
                                  }
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Maximal Price'
                                ),
                                onChanged: (val) {
                                  if(val.isNotEmpty) {
                                    setState(() => filterData['Price'] = val);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context),
                            child: const Text('Filter'),)
                        ],
                      );
                    },
                    barrierDismissible: true,
                  );
                },
                child: const Text("Filter")),
            const SizedBox(height: 5.0),
            DoctorList(filters: filterData, uid: widget.uid),
          ],
        ),
      ),
      const Text("My Requests"),
      const Text("Chats"),
      const Deposit(),
      const Text("Settings")
    ];

    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().allUsers,
      initialData: null,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
            backgroundColor: Colors.tealAccent[100],
            elevation: 0.0,
            title: Text('MedNEX', style: TextStyle(
              color: Colors.cyanAccent[700],
            ), textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              OutlinedButton.icon(onPressed: () async{
                await _auth.signOut();
              }, icon: const Icon(Icons.logout), label: const Text(''))
            ]
        ),
        body: options.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_motion),
              label: 'My Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Deposit'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.cyan[100],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
