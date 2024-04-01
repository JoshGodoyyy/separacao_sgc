import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/fornecedor_model.dart';
import 'package:http/http.dart' as http;

class Fornecedor {
  String url = '${ApiConfig().url}/Provider';

  Future<FornecedorModel> fetchFornecedor(int id) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
      }),
    );

    try {
      return FornecedorModel.fromJson(
        jsonDecode(response.body),
      );
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<FornecedorModel> fetchCliente(int id) async {
    final response = await http.post(
      Uri.parse('$url/Client'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
      }),
    );

    try {
      return FornecedorModel.fromJson(
        jsonDecode(response.body),
      );
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
