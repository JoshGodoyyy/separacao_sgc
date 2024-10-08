import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/client_model.dart';

class Cliente {
  String url = '${ApiConfig().url}/Client';

  Future<List> fetchClientes(
    int idRoteiroEntrega,
    bool pedidosAgrupados,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiroEntrega,
          'pedidosAgrupados': pedidosAgrupados,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => ClienteModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
