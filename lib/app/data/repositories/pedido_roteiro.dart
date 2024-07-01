import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/pedido_roteiro_model.dart';

class PedidoRoteiro {
  String url = '${ApiConfig().url}/OrderRoute';

  Future<List> fetchPedidosNaoCarregados(
    String numeroEntrega,
    String cepEntrega,
    int idCliente,
    int idRoteiro,
    bool separarPedidos,
  ) async {
    final response = await http.post(
      Uri.parse('$url/Unloaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'idRoteiroEntrega': idRoteiro,
          'volumeAcessorio': 0,
          'volumeChapa': 0,
          'volumePerfil': 0,
          'pedidosAgrupados': "",
          'idCliente': idCliente,
          'carregado': 0,
          'setorEstoque': "",
          'idStatus': 0,
          'status': "",
          'separarPedidos': separarPedidos,
          'numeroEntrega': numeroEntrega,
          'cepEntrega': cepEntrega,
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

  Future<List> fetchPedidosCarregados(
    String numeroEntrega,
    String cepEntrega,
    int idCliente,
    int idRoteiro,
    bool separarPedidos,
  ) async {
    final response = await http.post(
      Uri.parse('$url/Loaded'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'idRoteiroEntrega': idRoteiro,
          'volumeAcessorio': 0,
          'volumeChapa': 0,
          'volumePerfil': 0,
          'pedidosAgrupados': "",
          'idCliente': idCliente,
          'carregado': 0,
          'setorEstoque': "",
          'idStatus': 0,
          'status': "",
          'separarPedidos': separarPedidos,
          'numeroEntrega': numeroEntrega,
          'cepEntrega': cepEntrega,
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

  Future<List> carregarPedido(
    int idPedido,
    String numeroEntrega,
    String cepEntrega,
    int idCliente,
    int idRoteiro,
    bool separarPedidos,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idPedido,
          'idRoteiroEntrega': idRoteiro,
          'idCliente': idCliente,
          'carregado': 1,
          'separarPedidos': separarPedidos,
        },
      ),
    );

    return fetchPedidosNaoCarregados(
      numeroEntrega,
      cepEntrega,
      idCliente,
      idRoteiro,
      separarPedidos,
    );
  }

  Future<List> descarregarPedido(
    int idPedido,
    String numeroEntrega,
    String cepEntrega,
    int idCliente,
    int idRoteiro,
    bool separarPedidos,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idPedido,
          'idRoteiroEntrega': idRoteiro,
          'idCliente': idCliente,
          'carregado': 0,
          'separarPedidos': separarPedidos,
        },
      ),
    );

    return fetchPedidosCarregados(
      numeroEntrega,
      cepEntrega,
      idCliente,
      idRoteiro,
      separarPedidos,
    );
  }

  Future fetchPedido(int idPedido) async {
    var response = await http.post(
      Uri.parse('$url/UpdateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idPedido,
        },
      ),
    );

    try {
      return PedidoRoteiroModel.fromJson(
        jsonDecode(response.body),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
