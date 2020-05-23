import 'dart:convert';

import 'package:dns/models/user.dart';
import 'package:dns/page/setting.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'package:http/http.dart' as http;

class Pik extends StatelessWidget {
  var image;

  JsonUser user;

  var np;

  var nw;
  var imageacc;
  Pik({this.image, this.user, this.np, this.nw, this.imageacc});
  var t1;
  @override
  Widget build(BuildContext context) {
    Future<bool> _storeImage(bytes) async {
      var j1 = Io.File(bytes.path).readAsBytesSync();
      t1 = base64.encode(j1);

      http.Response response = await http.post(
        'http://kaftech.org/keswa-api/profile/postEditUser',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "userProfileId": user.userProfileId.toInt(),
          "profilePhoto": t1
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: Container(
                  width: 500.0,
                  height: 500.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 100,
              left: MediaQuery.of(context).size.width / 5,
              child: Container(
                width: 200,
                height: 50,
                child: RaisedButton(
                  child: Center(
                      child: Text(
                    "This is you photo ",
                    style: TextStyle(color: Colors.black),
                  )),
                  color: Colors.white,
                  onPressed: () async {
                    var res = await _storeImage(image);
                    if (res == true) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Setting(
                          np: np,
                          nw: nw,
                          imgprof: base64.decode(t1),
                          img: imageacc,
                          user: user,
                        );
                      }));
                    } else {}
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
