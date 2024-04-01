import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/endereco_roteiro_entrega_model.dart';

class EnderecoRoteiroEntrega {
  String url = '${ApiConfig().url}/AdressOrderRoute';

  Future<List> fetchEnderecosRoteiro(int idRoteiro) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data
          .map((json) => EnderecoRoteiroEntregaModel.fromJson(json))
          .toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
