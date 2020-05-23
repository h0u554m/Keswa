import 'dart:convert';
import 'dart:math';

import 'package:dns/page/loginpage.dart';
import 'package:dns/page/publichomepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/base64info.dart';

void main() => runApp(MyApp());
var t = Colors.red;
var base641;
var numphone;
var numwats;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  function() async {
    http.Response response = await http.get(
      'http://kaftech.org/keswa-api/application/getApplicationConfig',
    );
    print(response);
    base64info info = base64info.fromJson(json.decode(response.body));
    if (mounted) {
      setState(() {
        base641 = base64.decode(info.responseData[6].configValue);
        numphone = info.responseData[0].configValue;
        numwats = info.responseData[1].configValue;

        print(base641);
      });
    }
  }

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 30),
    );
    function();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google SignIn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: t,
      ),
      home: base641 == null
          ? Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: animationController,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/sb1.png'),
                          ),
                        ),
                      ),
                      builder: (BuildContext context, Widget _widget) {
                        return new Transform.rotate(
                            angle: animationController.value * 10,
                            child: _widget);
                      },
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Project.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Publichomepage(
              np: numphone,
              nw: numwats,
              img: base641,
            ),
    );
  }
}
