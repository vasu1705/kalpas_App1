import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class user_signin {
  static String email;
  static String password;

  static Map<String, dynamic> tojson() =>
      {"email": email, "password": password};
}

class user_signup {
  static String email = "";
  static String username = "test", password = "", passwordConf = "";

  static Map<String, dynamic> tojson() => {
        "email": email,
        "password": password,
        "passwordConf": passwordConf,
        "username": username
      };

  bool check() {
    return passwordConf == password;
  }
}




