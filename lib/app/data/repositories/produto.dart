import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/produto_model.dart';
import 'package:http/http.dart' as http;

class Produto {
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
      return data.map((json) => ProdutoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> updateProduto(
    int idProduto,
    int separado,
    int tipoProduto,
    int idPedido,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateSeparado'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': separado,
        },
      ),
    );

    return fetchProdutos(tipoProduto, idPedido);
  }

  Future<List<dynamic>> updateEmbalado(
    int idProduto,
    int embalado,
    int tipoProduto,
    int idPedido,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateEmbalagem'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': embalado,
        },
      ),
    );

    return fetchProdutos(tipoProduto, idPedido);
  }

  Future<List<dynamic>> updateConferido(
    int idProduto,
    int conferido,
    int tipoProduto,
    int idPedido,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateConferido'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': conferido,
        },
      ),
    );

    return fetchProdutos(tipoProduto, idPedido);
  }
}
