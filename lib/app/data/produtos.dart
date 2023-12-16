import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/product_model.dart';
import 'package:http/http.dart' as http;

class Produtos {
  String url = '${ApiConfig().url}/Product';

  Future<List<dynamic>> fetchProdutos(int tipoProduto, int idPedido) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tipoProduto': tipoProduto,
        'idPedido': idPedido,
      }),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
