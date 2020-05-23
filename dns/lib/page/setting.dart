import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dns/models/user.dart';
import 'package:dns/page/Profille.dart';
import 'package:dns/page/publichomepage.dart';

import './pik.dart';
import 'package:dns/page/Home.dart';
import 'package:dns/page/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' as Io;
import 'package:path/path.dart';
import 'package:async/async.dart';

class Setting extends StatefulWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final img;

  final user;

  final np;

  final nw;

  final imgprof;

  Setting({this.img, this.user, this.np, this.nw, this.imgprof});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var _image;
  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void settingModalBottomSheet(context, user) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(child: Text('Photo gallery')),
                    onTap: () async {
                      var j = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Pik(
                          np: widget.np,
                          nw: widget.nw,
                          user: user,
                          image: j,
                          imageacc: widget.img,
                        );
                      }));
                    }),
                ListTile(
                  title: Center(child: Text('Take photo')),
                  onTap: () {},
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  color: Colors.grey,
                ),
                ListTile(
                  title: Center(child: Text('Cancel')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Setting", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.dehaze),
          onPressed: () {
            if (_scaffoldKey.currentState.isDrawerOpen == false) {
              _scaffoldKey.currentState.openDrawer();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
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
                                  : MemoryImage(widget.imgprof),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      widget.user.userName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 183,
                  color: Colors.grey[800],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      buildFlatButton(context, Icons.home, "Home", () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                          return Home(
                            imgprof: widget.imgprof,
                            np: widget.np,
                            nw: widget.nw,
                            img: widget.img,
                            user: widget.user,
                          );
                        }));
                      }),
                      buildFlatButton(context, Icons.settings, "Settings", () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Setting(
                            np: widget.np,
                            nw: widget.nw,
                            imgprof: widget.imgprof,
                            img: widget.img,
                            user: widget.user,
                          );
                        }));
                      }),
                      buildFlatButton(context, Icons.exit_to_app, "Logout", () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Publichomepage(
                            np: widget.np,
                            nw: widget.nw,
                            img: widget.img,
                          );
                        }));
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          settingModalBottomSheet(context, widget.user);
                        },
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
                                    : MemoryImage(widget.imgprof),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Profile(
                                user: widget.user, img: widget.imgprof);
                          }));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 124,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.user.userName,
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 9,
                    ),
                    Icon(Icons.phone),
                    SizedBox(
                      width: 9,
                    ),
                    Text("+" + widget.np, style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 9,
                    ),
                    FaIcon(FontAwesomeIcons.whatsapp),
                    SizedBox(
                      width: 9,
                    ),
                    Text("+" + widget.nw, style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 9,
                    ),
                    FaIcon(FontAwesomeIcons.facebookSquare),
                    SizedBox(
                      width: 9,
                    ),
                    Text("https://www.facebook.com/SHEIN",
                        style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "About",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton buildFlatButton(BuildContext context, icons, text, function) {
    return FlatButton(
      onPressed: function,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Row(
            children: <Widget>[
              Icon(
                icons,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
