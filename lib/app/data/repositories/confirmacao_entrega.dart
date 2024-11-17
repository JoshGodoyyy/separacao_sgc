import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/confirmacao_entrega_model.dart';
import 'package:http/http.dart' as http;

class ConfirmacaoEntrega {
  final String _url = '${ApiConfig().url}/DeliveryConfirmation';

  Future<void> confirmar(List<ConfirmacaoEntregaModel> pedidos) async {
    await http.post(
      Uri.parse('$_url/Confirm'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pedidos.map((pedido) => pedido.toJson()).toList()),
    );
  }
}
