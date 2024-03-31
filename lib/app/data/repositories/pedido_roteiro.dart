import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/pedido_roteiro_model.dart';

class PedidoRoteiro {
  String url = '${ApiConfig().url}/OrderRoute';

  Future<List> fetchPedidosNaoCarregados(PedidoRoteiroModel pedido) async {
    final response = await http.post(
      Uri.parse('$url/Unloaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'idRoteiroEntrega': pedido.idRoteiroEntrega,
          'idCliente': pedido.idCliente,
          'carregado': 0,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => PedidoRoteiroModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List> fetchPedidosCarregados(PedidoRoteiroModel pedido) async {
    final response = await http.post(
      Uri.parse('$url/Loaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'idRoteiroEntrega': pedido.idRoteiroEntrega,
          'idCliente': pedido.idCliente,
          'carregado': 0,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => PedidoRoteiroModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List> carregarPedido(PedidoRoteiroModel pedido) async {
    await http.post(
      Uri.parse('$url/UpdateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': pedido.id,
          'idRoteiroEntrega': pedido.idRoteiroEntrega,
          'idCliente': pedido.idCliente,
          'carregado': 1,
        },
      ),
    );

    return fetchPedidosNaoCarregados(pedido);
  }

  Future<List> descarregarPedido(PedidoRoteiroModel pedido) async {
    await http.post(
      Uri.parse('$url/UpdateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': pedido.id,
          'idRoteiroEntrega': pedido.idRoteiroEntrega,
          'idCliente': pedido.idCliente,
          'carregado': 0,
        },
      ),
    );

    return fetchPedidosCarregados(pedido);
  }
}
