import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dns/models/base64info.dart';
import 'package:dns/models/user.dart';
import 'package:dns/page/Home.dart';
import 'package:dns/page/sginup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginWithRestfulApi extends StatefulWidget {
  var test;

  var base641;

  final np;

  final nw;

  LoginWithRestfulApi({this.test, this.base641, this.np, this.nw});
  @override
  _LoginWithRestfulApiState createState() => _LoginWithRestfulApiState(base641);
}

class _LoginWithRestfulApiState extends State<LoginWithRestfulApi>
    with TickerProviderStateMixin {
  var base641;

  _LoginWithRestfulApiState(this.base641);
  static var uri = "http://kaftech.org/keswa-api/";

  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
      });
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 30),
    );

    animationController.repeat();
  }

  static Dio dio = Dio(options);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<dynamic> _loginUser(String userid, String password) async {
    try {
      Options options = Options(
        contentType: ContentType.parse('application/json').toString(),
      );

      Response response = await dio.get('/profile/getUserMain?',
          queryParameters: {"userId": userid, "userPass": password},
          options: options);
      var responseJson = json.decode(response.data);
      var t1 = responseJson["responseCode"];
      if (response.statusCode == 200 && t1 != "303") {
        _isLoading = true;
        return responseJson;
      } else if (response.statusCode == 200 && t1 == "303") {
        return '303';
      } else
        throw Exception('Authentication Error');
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: _isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: AnimatedBuilder(
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
                  ),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      child: Center(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          child: Image.memory(widget.base641),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'UserName',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )),
                        color: Colors.black,
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          var res = await _loginUser(
                              _emailController.text, _passwordController.text);
                          setState(() => _isLoading = false);
                          if (res != "303") {
                            JsonUser user = JsonUser.fromJson(res);

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                return Home(
                                  imgprof: base64.decode(user.profilePhoto),
                                  np: widget.np,
                                  nw: widget.nw,
                                  img: base641,
                                  user: user,
                                );
                              }));
                            } else {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("Wrong email or")));
                            }
                          } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute<Null>(
                                    builder: (BuildContext context) {
                              return LoginWithRestfulApi(
                                base641: widget.base641,
                                test: 1,
                              );
                            }));
                          }
                        },
                      ),
                    ),
                    widget.test < 0
                        ? Text(
                            "Wrong login",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        child: Center(
                            child: Text(
                          "Need an account?",
                          style: TextStyle(color: Colors.white),
                        )),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Sginup(
                              by: widget.base641,
                            );
                          }));
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
