import 'dart:convert';

import 'package:sgc/app/models/embalagem_model.dart';

import '../../config/api_config.dart';
import 'package:http/http.dart' as http;

class Embalagem {
  String url = '${ApiConfig().url}/Packaging';

  Future<List> fetchEmbalagens(int idPedido) async {
    var response = await http.post(
      Uri.parse('$url/Get'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idPedido,
        },
      ),
    );

    try {
      List data = jsonDecode(response.body);
      return data
          .map(
            (json) => EmbalagemModel.fromJson(json),
          )
          .toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
