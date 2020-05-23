import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sginup extends StatefulWidget {
  var by;

  Sginup({this.by, Key key}) : super(key: key);

  @override
  _SginupState createState() => _SginupState();
}

bool res = false;
Future<bool> createuser(String userId, userPass, userName, genderCode,
    birthDate, email, phoneNumber) async {
  final http.Response response = await http.post(
    'http://kaftech.org/keswa-api/profile/postNewUser',
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(<String, String>{
      "userId": userId,
      "userPass": userPass,
      "userTypeCode": "USER",
      "userName": userName,
      "genderCode": genderCode,
      "birthDate": birthDate,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePhoto": null
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

class _SginupState extends State<Sginup> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userId;
  String _userPass;
  String _username;
  String _useremail;
  String _phoneNumber;
  String _bt;
  int validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(value)) {
      return 2;
    }
    return null;
  }

  bool men = true;
  bool women = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Login",
              style: TextStyle(color: Colors.black),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.memory(widget.by),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _userId = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _userPass = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _username = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Fullname',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      _useremail = value;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (validateMobile(value) == 1) {
                        return 'Please enter mobile number';
                      } else if (validateMobile == 2) {
                        return 'Please enter valid mobile number';
                      } else {
                        _phoneNumber = value;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'phonenumber',
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Gender",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // [Monday] checkbox
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Men"),
                              Checkbox(
                                value: men,
                                onChanged: (bool value) {
                                  setState(() {
                                    men = value;
                                    women = !value;
                                  });
                                },
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("women"),
                              Checkbox(
                                value: women,
                                onChanged: (bool value) {
                                  setState(() {
                                    women = value;
                                    men = !value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Date of Birth :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: DateTimeField(
                              textAlign: TextAlign.center,
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              validator: (currentValue) {
                                if (currentValue == null) {
                                  return 'Please enter Date of Birth ';
                                }
                                _bt = currentValue.toString();
                                return null;
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      child: Center(
                          child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      )),
                      color: Colors.black,
                      onPressed: () async {
                        if (_formKey.currentState.validate() &&
                            (men == true || women == true)) {
                          var bools = false;
                          bools = await createuser(
                              _userId,
                              _userPass,
                              _username,
                              men == true ? "m" : "f",
                              _bt
                                  .substring(0, _bt.indexOf(" "))
                                  .replaceAll("-", "/"),
                              _useremail,
                              _phoneNumber);
                          if (bools = true) {
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('problem en you connection ')));
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
