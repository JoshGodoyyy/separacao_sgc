import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/config/capitalize_text.dart';
import 'package:sgc/app/config/user.dart';

import '../models/user_model.dart';

import 'package:http/http.dart' as http;

class UserDAO {
  String url = '${ApiConfig().url}/User';

  Future<bool> auth(User user) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'nome': user.user!.toUpperCase(),
          'senha': user.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      UserConstants()
          .setUserName(CapitalizeText.capitalizeFirstLetter(user.user!));
      return true;
    } else if (response.statusCode == 401) {
      throw Exception('Usuário e/ou senha inválidos');
    } else if (response.statusCode == 404) {
      throw Exception('Servidor não encontrado :(');
    } else {
      throw Exception('Ops, ocorreu um erro: ${response.statusCode}');
    }
  }

  Future<User> fetchUser(int id) async {
    final response = await http.post(
      Uri.parse('$url/GetUser'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'id': int.parse(id.toString())},
      ),
    );

    try {
      return User.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
