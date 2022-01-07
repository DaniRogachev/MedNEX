import 'package:flutter/material.dart';
import 'package:med_nex/Models/user.dart';
import 'package:med_nex/Services/auth.dart';

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
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _uinFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  _nextFocus(FocusNode focusNode){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
          backgroundColor: Colors.tealAccent[100],
          elevation: 0.0,
          title: Text('Doctor sign up', style: TextStyle(
            color: Colors.cyanAccent[700],
          ))
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                const SizedBox(height: 10.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter an email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_usernameFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email'
                    ),
                    onChanged: (val){
                      setState(() => email = val);
                    }
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 128,
                      child: TextFormField(
                          validator: (val){
                            if(val!=null && val.isEmpty){
                              return "Enter a name";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _usernameFocusNode,
                          onFieldSubmitted: (String value){
                            _nextFocus(_middleNameFocusNode);
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'First name'
                          ),
                          onChanged: (val){
                            setState(() => username = val);
                          }
                      ),
                    ),
                    SizedBox(
                      width: 128,
                      child: TextFormField(
                          validator: (val){
                            if(val!=null && val.isEmpty){
                              return "Enter a middle name";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _middleNameFocusNode,
                          onFieldSubmitted: (String value){
                            _nextFocus(_surnameFocusNode);
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Middle name'
                          ),
                          onChanged: (val){
                            setState(() => middleName = val);
                          }
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a surname";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _surnameFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_passwordFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Surname'
                    ),
                    onChanged: (val){
                      setState(() => surname = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a password";
                      }
                      else if(val != null && val.length<8){
                        return "The password must be at least 8 characters";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_medicalSpecialtyFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password'
                    ),
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a medical Speciality";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _medicalSpecialtyFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_experienceFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Medical Speciality'
                    ),
                    onChanged: (val){
                      setState(() => medicalSpecialty = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter experience";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _experienceFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_cityFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Experience'
                    ),
                    onChanged: (val){
                      setState(() => experience = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a city";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _cityFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_uinFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'City'
                    ),
                    onChanged: (val){
                      setState(() => city = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a UIN";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _uinFocusNode,
                    onFieldSubmitted: (String value){
                      _nextFocus(_priceFocusNode);
                    },
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'UIN'
                    ),
                    onChanged: (val){
                      setState(() => docUin = val);
                    }
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                    validator: (val){
                      if(val!=null && val.isEmpty){
                        return "Enter a price for consultations";
                      }
                      return null;
                    },
                    focusNode: _priceFocusNode,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Consultation price (in leva)'
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      setState(() => price = val);
                    }
                ),
                const SizedBox(height: 20.0),
                OutlinedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      RegularUser? user = await _authService.doctorRegister(email, username, middleName, surname, password, medicalSpecialty, experience, city, docUin, price);
                      if(user==null){
                        print('There is an error');
                      }else{
                        Navigator.pop(context);
                        print('Successful');
                      }
                    }else{
                      print("There is something which is not working");
                    }
                  },
                  child: const Text(
                      'Register'
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text(
                        "Back"
                    )
                ),
              ]
          ),
        ),
      ),
    );
  }
}
