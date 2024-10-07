import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/api_config.dart';
import '../../models/nivel_senha_model.dart';

class NivelSenha {
  final String _url = '${ApiConfig().url}/PasswordLevel';

  Future<bool> verificarNivelSenha(NivelSenhaModel nivelSenha) async {
    var response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'nivel': nivelSenha.nivel,
          'idUsuario': nivelSenha.idUsuario,
        },
      ),
    );

    try {
      return jsonDecode(response.body);
    } catch (ex) {
      throw Exception(
        ex.toString(),
      );
    }
  }

  Future<bool> verificarAcesso(NivelSenhaModel nivelSenha) async {
    var response = await http.post(
      Uri.parse('$_url/GetPasswordLevel'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'nivel': nivelSenha.nivel},
      ),
    );

    return response.statusCode == 200;
  }
}
