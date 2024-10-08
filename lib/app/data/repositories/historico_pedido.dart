import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/models/historico_pedido_model.dart';

import '../../config/api_config.dart';

class HistoricoPedido {
  final String _url = '${ApiConfig().url}/OrderHistoric';

  Future<void> adicionarHistorico(HistoricoPedidoModel historico) async {
    await http.post(
      Uri.parse('$_url/InsertLog'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'idPedido': historico.idPedido,
          'idStatus': historico.idStatus,
          'status': historico.status,
          'idUsuario': historico.idUsuario,
          'nomeUsuario': UserConstants().userName,
          'data': historico.data,
          'chaveFuncionario': historico.chaveFuncionario,
        },
      ),
    );
  }
}
