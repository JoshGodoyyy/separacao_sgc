import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/config/user.dart';
import '../../models/user_model.dart';

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
      var usuario = User.fromJson(jsonDecode(response.body));
      UserConstants().setUserData(usuario);
      return true;
    } else if (response.statusCode == 401) {
      throw Exception('Dado(s) de entrada inválido(s)');
    } else if (response.statusCode == 404) {
      throw Exception('Servidor não encontrado :(');
    } else {
      throw Exception('Ops, ocorreu um erro: ${response.statusCode}');
    }
  }
}
