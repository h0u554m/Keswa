import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Picture with ChangeNotifier {
  final String picName;

  Picture({
    @required this.picName,
  });


}
