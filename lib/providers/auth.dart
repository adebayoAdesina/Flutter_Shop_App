import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exception/http_exception.dart';

class AuthMethod with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return '';
  }

  Future<void> auths(String email, String password, String auth) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$auth?key=AIzaSyCD6mNl0r-IpqSUk9im2VFIHIOWbTJi6as';
    // print(jsonDecode(response.body));
    try {
      var value = jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      );
      var response = await http.post(Uri.parse(url), body: value);
      var responseCheck = jsonDecode(response.body);
      if (responseCheck['error'] != null) {
        // print(responseCheck['error']['message']);
        throw HttpException(responseCheck['error']['message']);
      }
      _token = responseCheck['idToken'];

      _userId = responseCheck['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseCheck['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    auths(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    auths(email, password, 'signInWithPassword');
  }
}
