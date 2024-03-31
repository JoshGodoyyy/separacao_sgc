import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

class RoteiroEntrega {
  String url = '${ApiConfig().url}/DeliveryRoute';

  Future<List> fetchRoteiros() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => RoteiroEntregaModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
