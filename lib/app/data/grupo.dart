import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/models/group_model.dart';

import '../config/api_config.dart';

class Grupo {
  String url = '${ApiConfig().url}/Group';

  Future<List<dynamic>> fetchGrupos(int idPedido, int tipoProduto) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'idPedido': idPedido,
          'tipoProduto': tipoProduto,
        },
      ),
    );

    try {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body.trim());
        return data.map((json) => GrupoModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
