import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/config/capitalize_text.dart';
import 'package:sgc/app/data/user.dart';

import '../models/login_model.dart';

import 'package:http/http.dart' as http;

class LoginDAO {
  late String url;

  Future<bool> auth(LoginModel user) async {
    ApiConfig().getUrl();
    url = ApiConfig().url!;
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'name': user.user.toUpperCase(),
          'password': user.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      User().setUserName(CapitalizeText.capitalizeFirstLetter(user.user));
      return true;
    } else {
      throw Exception('Erro ao realizar login');
    }
  }
}
