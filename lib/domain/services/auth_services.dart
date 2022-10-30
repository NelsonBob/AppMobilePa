import 'dart:convert';
import 'package:flutter_application_1/data/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/storage/secure_storage.dart';
import 'package:flutter_application_1/domain/models/response/response_login.dart';
import 'package:flutter_application_1/data/env/env.dart';

class AuthServices {
  Future<ResponseLogin> login(String email, String password) async {
    final resp = await http.post(Uri.parse('${Environment.urlApi}/authLogin'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    print(resp);
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseLogin> renewLogin() async {
    final loginDetails = await SharedService.loginDetails();

    final resp = await http
        .get(Uri.parse('${Environment.urlApi}/auth/renewLogin'), headers: {
      'Accept': 'application/json',
      'Authorization': loginDetails!.token!
    });
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }
}

final authServices = AuthServices();
