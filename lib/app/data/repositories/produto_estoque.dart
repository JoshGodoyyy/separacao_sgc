import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/produto_estoque_model.dart';

class ProdutoEstoque {
  String url = '${ApiConfig().url}/StockProduct';

  Future<List<dynamic>> fetchEstoque() async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'tabela': '0',
          'idCliente': '1',
          'idTratamento': 'ESP',
          'precoPerfisTratamento': 1,
          'bloqueioTabelaEspecial': false,
          'precoUltimoPedido': false,
          'filterInfo': null,
          'filterListID': ''
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => ProdutoEstoqueModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
