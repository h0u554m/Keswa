import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dns/models/Product.dart';
import 'package:dns/models/user.dart';
import 'package:dns/page/publichomepage.dart';
import 'package:dns/page/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  final img;

  final np;

  final nw;

  final imgprof;

  Home({@required this.user, this.img, this.np, this.nw, this.imgprof});

  final JsonUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Key _k1 = new GlobalKey();
  bool _isLoading = false;
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

  Product product;
  static BaseOptions options = BaseOptions(
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        } else {
          return false;
        }
      });

  static Dio dio = Dio(options);

  var ti;
  Future<dynamic> _getproduct(String url) async {
    try {
      Options options = Options(
        contentType: ContentType.parse('application/json').toString(),
      );
      url = url.replaceAll("&", "%26");

      Response response = await dio.get(
          "http://kaftech.org/keswa-api/product/getProduct?shareURL=" + url,
          options: options);
      var responseJson;

      var t1;
      if (response != null) {
        responseJson = json.decode(response.data);

        t1 = responseJson["responseCode"];
      }
      if (response.statusCode == 200 && t1 != "303") {
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

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var pages = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Text(
            "Keswa",
            style: TextStyle(color: Colors.black),
          ),
        )),
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
          child: SingleChildScrollView(
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
                      Center(
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: widget.user.profilePhoto == null
                                    ? AssetImage("assets/user.png")
                                    : MemoryImage(widget.imgprof)),
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
                              np: widget.np,
                              nw: widget.nw,
                              imgprof: widget.imgprof,
                              img: widget.img,
                              user: widget.user,
                            );
                          }));
                        }),
                        buildFlatButton(context, Icons.settings, "Settings",
                            () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Setting(
                              np: widget.np,
                              nw: widget.nw,
                              imgprof: widget.imgprof,
                              img: widget.img,
                              user: widget.user,
                            );
                          }));
                        }),
                        buildFlatButton(context, Icons.exit_to_app, "Logout",
                            () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
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
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Icon(Icons.link),
                                onPressed: () {
                                  ti = null;
                                  _formKey.currentState.reset();
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  key: _k1,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    ti = value;
                                    return null;
                                  },
                                  onEditingComplete: () async {
                                    if (_formKey.currentState.validate()) {
                                      FocusScope.of(context).unfocus();
                                      setState(() => _isLoading = true);
                                      var res = await _getproduct(ti);
                                      setState(() => _isLoading = false);
                                      if (res != null) {
                                        product = Product.fromMap(res);
                                        setState(() {});
                                      }
                                    }
                                  }),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _formKey.currentState.reset();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ti == null
                      ? buildColumn(context, widget.img, widget.np, widget.nw)
                      : _isLoading == true
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
                                  builder:
                                      (BuildContext context, Widget _widget) {
                                    return new Transform.rotate(
                                        angle: animationController.value * 10,
                                        child: _widget);
                                  },
                                ),
                              ),
                            )
                          : product.responseCode != "200"
                              ? Center(
                                  child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: Center(
                                            child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Icon(
                                              Icons.error,
                                              size: 100,
                                            ),
                                            Text(
                                              "Item NoT Found",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            Container(),
                                          ],
                                        )),
                                      ),
                                    ],
                                  ),
                                ))
                              : Container(
                                  child: Column(
                                    children: <Widget>[
                                      CarouselSlider.builder(
                                        itemCount: product
                                            .responseData.imagesUrl.length,
                                        itemBuilder: (BuildContext context,
                                                int itemIndex) =>
                                            Container(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  product.responseData
                                                      .imagesUrl[itemIndex],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        options: CarouselOptions(
                                          height: 300,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.9,
                                          aspectRatio: 2.0,
                                          initialPage: 2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            color: Colors.grey[300],
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    product.responseData
                                                        .productName,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    children: <Widget>[
                                                      FaIcon(FontAwesomeIcons
                                                          .moneyBill),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        product.responseData
                                                                .egpFinalPrice
                                                                .toString() +
                                                            " EGP",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("size"),
                                                      Container(
                                                        height: 90,
                                                        child: Center(
                                                          child: Expanded(
                                                            child: Container(
                                                                height: 90,
                                                                child: Center(
                                                                  child: new GridView
                                                                          .builder(
                                                                      gridDelegate:
                                                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            4,
                                                                        childAspectRatio:
                                                                            2,
                                                                      ),
                                                                      itemCount: product
                                                                          .responseData
                                                                          .sizesStr
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext ctxt,
                                                                              int index) {
                                                                        return Card(
                                                                          elevation:
                                                                              5,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            side:
                                                                                BorderSide(
                                                                              color: Colors.black,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            highlightColor:
                                                                                Colors.blue[300],
                                                                            child:
                                                                                Expanded(
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 4,
                                                                                height: 40,
                                                                                child: Center(child: Text(product.responseData.sizesStr[index].toString() + " ")),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context, img, np, nw) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2 - 100,
          color: Colors.grey[300],
          child: Center(
            child: Container(
              width: 150.0,
              height: 150.0,
              child: Image.memory(widget.img),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              "Hello, valued shoppers, we developed this application to make the shopping process easier to you, and we are planning to expand it till getting your complete satisfaction",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.error),
                SizedBox(
                  width: 5,
                ),
                Text("Please entre the item link to get more detail")
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                Text("+" + np, style: TextStyle(fontSize: 16))
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
                Text(
                  "+" + nw,
                  style: TextStyle(fontSize: 16),
                )
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
      ],
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
