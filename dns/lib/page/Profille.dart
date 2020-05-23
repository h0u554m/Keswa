import 'dart:convert';

import 'package:dns/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './setting.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final JsonUser user;

  final img;

  const Profile({Key key, this.user, this.img}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  Key _k1 = new GlobalKey();
  Key _k2 = new GlobalKey();
  String _userPass;
  Future<bool> changemdp(userPass) async {
    final http.Response response = await http.post(
      'http://kaftech.org/keswa-api/profile/postEditUser',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "userProfileId": widget.user.userProfileId,
        "userPass": userPass,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var totoalwith = MediaQuery.of(context).size.width;
    var totoalhi = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: totoalwith,
          height: totoalhi,
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: totoalwith,
                height: totoalhi / 4,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.userName.replaceFirst(widget.user.userName[0],
                          widget.user.userName[0].toUpperCase()),
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        focusColor: Colors.red,
                        child: Center(
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: widget.user.profilePhoto == null
                                    ? AssetImage("assets/user.png")
                                    : MemoryImage(widget.img),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("User since April 2020"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("BASIC PROFILE"),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.user.userName,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.email),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.user.email,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.error),
                                    Text(
                                      "Here's a little bit about me.and so\n   it goes on and on on",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('PRIVATE INFORMATION'),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.cake),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.user.birthDate,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone_android),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.user.phoneNumber,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    FaIcon(FontAwesomeIcons.venusMars),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      widget.user.genderCode == "m"
                                          ? "Male"
                                          : "Femelle",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Icon(Icons.mode_edit, color: Colors.green),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('CHANGE PASSWORD'),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              key: _k1,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                _userPass = value;
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.mode_edit, color: Colors.green),
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Entre New Pasword',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              key: _k2,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                _userPass = value;
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.mode_edit, color: Colors.green),
                                prefixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Retype New Pasword',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: totoalwith,
                        height: 50,
                        child: RaisedButton(
                            child: Center(
                                child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            )),
                            color: Colors.black,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var res = await changemdp(_userPass);
                                if (res == true) {
                                  print("ok");
                                } else {
                                  print("problem");
                                }
                              }
                            }),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
