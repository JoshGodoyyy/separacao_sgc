import 'dart:convert';

import 'package:sgc/app/models/tipo_entrega_model.dart';

import '../../config/api_config.dart';

import 'package:http/http.dart' as http;

class TipoEntregaDAO {
  String url = '${ApiConfig().url}/DeliveryType';

  Future<TipoEntrega> fetchTipoEntrega(int id) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'id': int.parse(id.toString())},
      ),
    );

    try {
      return TipoEntrega.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
