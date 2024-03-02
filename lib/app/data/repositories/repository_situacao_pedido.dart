import 'dart:convert';

import 'package:sgc/app/models/situacao_pedido_model.dart';
import '../../config/api_config.dart';
import 'package:http/http.dart' as http;

class RepositorySituacaoPedido {
  String url = '${ApiConfig().url}/OrderSituation';

  Future<SituacaoPedidoModel> situacaoPedido(int id) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
      }),
    );

    try {
      var obj = SituacaoPedidoModel.fromJson(
        jsonDecode(response.body),
      );
      return obj;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
