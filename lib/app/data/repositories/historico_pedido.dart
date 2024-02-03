import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/models/historico_pedido_model.dart';

import '../../config/api_config.dart';

class HistoricoPedido {
  final String _url = ApiConfig().url;

  Future<void> adicionarHistorico(HistoricoPedidoModel historico) async {
    await http.post(
      Uri.parse('$_url/Insert'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': historico.id,
          'idPedido': historico.idPedido,
          'idStatus': historico.idStatus,
          'status': historico.status,
          'idUsuario': historico.idUsuario,
          'nomeUsuario': historico.nomeUsuario,
          'data': historico.data,
          'chaveFuncionario': historico.chaveFuncionario,
        },
      ),
    );
  }
}
