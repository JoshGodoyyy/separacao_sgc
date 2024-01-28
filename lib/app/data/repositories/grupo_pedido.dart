import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

class GrupoPedido {
  String url = '${ApiConfig().url}/OrderGroup';

  Future<void> apagarGruposInconsistentes(int id) async {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'idPedido': id,
        },
      ),
    );
  }
}
