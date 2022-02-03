import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/auth.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:med_nex/Models/title.dart';
import 'package:med_nex/Models/medical_specialty.dart';

class RegisterDoc extends StatefulWidget {
  const RegisterDoc({Key? key}) : super(key: key);

  @override
  _RegisterDocState createState() => _RegisterDocState();
}

class _RegisterDocState extends State<RegisterDoc> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _surnameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _medicalSpecialtyFocusNode = FocusNode();
  final FocusNode _experienceFocusNode = FocusNode();
  final FocusNode _uinFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  late String email;
  late String username;
  late String middleName;
  late String surname;
  late String password;
  late String medicalSpecialty;
  late String experience;
  late String city;
  late String docUin;
  late String price;
  List<MedTitle?> selectedTitles = [];
  List<MedSpecialty?> selectedSpecialties = [];

  List<String> cities = ["София", "София-област", "Благоевград", "Враца", "Ловеч", "Кюстендил", "Перник", "Пазарджик", "Монтана", "Видин", "Смолян", "Кърджали", "Пловдив", "Стара Загора", "Сливен", "Ямбол", "Бургас", "Хасково", "Варна", "Шумен", "Търговище", "Разград", "Силистра", "Плевен", "Велико Търново", "Габрово", "Русе", "Добрич"];

  static List<MedTitle> medTitles = [
    MedTitle(id: 1, name: 'Doctor of Medicine by research'),
    MedTitle(id: 2, name: 'Master of Clinical Medicine'),
    MedTitle(id: 3, name: "Master of Medical Science"),
    MedTitle(id: 4, name: "Master of Public Health"),
    MedTitle(id: 5, name: "Master of Medicine"),
    MedTitle(id: 6, name: "Master of Philosophy"),
    MedTitle(id: 7, name: "Master of Philosophy Ophthalmology"),
    MedTitle(id: 8, name: "Master of Public Health and Ophthalmology"),
    MedTitle(id: 9, name: "Master of Surgery"),
    MedTitle(id: 10, name: "Master of Science"),
    MedTitle(id: 11, name: "Doctor of Clinical Medicine"),
    MedTitle(id: 12, name: "Doctor of Clinical Surgery"),
    MedTitle(id: 13, name: "Doctor of Medical Science"),
    MedTitle(id: 14, name: "Doctor of Surgery"),
    MedTitle(id: 15, name: "Doctor of Podiatric Medicine"),
  ];


  final titles = medTitles
      .map((medTitle) => MultiSelectItem<MedTitle?>(medTitle, medTitle.name))
      .toList();

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('Doctor sign up',
              style: TextStyle(
                color: Colors.cyanAccent[700],
              ))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            const SizedBox(height: 10.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter an email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (String value) {
                  _nextFocus(_usernameFocusNode);
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Email'),
                onChanged: (val) {
                  setState(() => email = val);
                }),
            const SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 128,
                  child: TextFormField(
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return "Enter a name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _usernameFocusNode,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_middleNameFocusNode);
                      },
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'First name'),
                      onChanged: (val) {
                        setState(() => username = val);
                      }),
                ),
                SizedBox(
                  width: 128,
                  child: TextFormField(
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return "Enter a middle name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _middleNameFocusNode,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_surnameFocusNode);
                      },
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Middle name'),
                      onChanged: (val) {
                        setState(() => middleName = val);
                      }),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a surname";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                focusNode: _surnameFocusNode,
                onFieldSubmitted: (String value) {
                  _nextFocus(_passwordFocusNode);
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Surname'),
                onChanged: (val) {
                  setState(() => surname = val);
                }),
            const SizedBox(height: 20.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a password";
                  } else if (val != null && val.length < 8) {
                    return "The password must be at least 8 characters";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (String value) {
                  _nextFocus(_medicalSpecialtyFocusNode);
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Password'),
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            const SizedBox(height: 20.0),
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
                  selectedSpecialties = val as List<MedSpecialty?>;
                }
            ),
            const SizedBox(height: 20.0),
            MultiSelectBottomSheetField(
              initialChildSize: 0.4,
              listType: MultiSelectListType.CHIP,
              searchable: true,
              items: titles,
              title: const Text("Titles"),
              buttonIcon: const Icon(
                Icons.add
              ),
              buttonText: const Text("Titles"),
              onConfirm: (val){
                selectedTitles = val as List<MedTitle?>;
              }
            ),
            const SizedBox(height: 20.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter experience";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                focusNode: _experienceFocusNode,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Experience'),
                onChanged: (val) {
                  setState(() => experience = val);
                }),
            const SizedBox(height: 20.0),
            TextDropdownFormField(
                options: cities,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: "Region"),
                dropdownHeight: 260,
                validator: (dynamic val){
                    if(val==null || val.isEmpty){
                      return "Enter a region";
                    }
                    return null;
                  },
                onChanged: (dynamic val) {
                  setState(() {
                    city = val;
                  });
                }),
            const SizedBox(height: 20.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a UIN";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                focusNode: _uinFocusNode,
                onFieldSubmitted: (String value) {
                  _nextFocus(_priceFocusNode);
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'UIN'),
                onChanged: (val) {
                  setState(() => docUin = val);
                }),
            const SizedBox(height: 20.0),
            TextFormField(
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Enter a price for consultations";
                  }
                  return null;
                },
                focusNode: _priceFocusNode,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Consultation price (in leva)'),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  setState(() => price = val);
                }),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FirebaseUser? user = await _authService.doctorRegister(
                      email,
                      username,
                      middleName,
                      surname,
                      password,
                      experience,
                      city,
                      docUin,
                      price,
                      selectedTitles,
                      selectedSpecialties);
                  if (user == null) {
                    print('There is an error');
                  } else {
                    Navigator.pop(context);
                    print('Successful');
                  }
                } else {
                  print("There is something which is not working");
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back")),
          ]),
        ),
      ),
    );
  }
}
