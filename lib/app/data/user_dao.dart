import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
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
          'apelido': null,
          'idLiberacao': user.idLiberacao,
        },
      ),
    );

    if (response.statusCode == 200) {
      String apelido = await UserDAO().fetchApelido(user.idLiberacao!);
      UserConstants().setUserName(apelido);
      return true;
    } else if (response.statusCode == 401) {
      throw Exception('Dado(s) de entrada inválido(s)');
    } else if (response.statusCode == 404) {
      throw Exception('Servidor não encontrado :(');
    } else {
      throw Exception('Ops, ocorreu um erro: ${response.statusCode}');
    }
  }

  Future<String> fetchApelido(String idLiberacao) async {
    final response = await http.post(
      Uri.parse('$url/GetApelido'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'nome': '',
          'senha': '',
          'apelido': '',
          'idLiberacao': idLiberacao,
        },
      ),
    );

    try {
      var apelido = response.body;
      return apelido;
    } catch (ex) {
      throw Exception(ex.toString());
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
