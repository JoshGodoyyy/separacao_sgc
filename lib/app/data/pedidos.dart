import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/order_model.dart';

class Pedidos with ChangeNotifier {
  List pedidosSeparar = [];
  List pedidosSeparando = [];
  List pedidosEmbalagem = [];
  List pedidosConferencia = [];
  List pedidosFaturar = [];
  List pedidosLogistica = [];
  String url = '${ApiConfig().url}/Order';

  Future<void> fetchData(int idSituacao) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "id": idSituacao,
        },
      ),
    );

    try {
      List data = jsonDecode(response.body);

      switch (idSituacao) {
        case 2:
          pedidosSeparar = data.map((json) => Pedido.fromJson(json)).toList();
          break;
        case 3:
          pedidosSeparando = data.map((json) => Pedido.fromJson(json)).toList();
          break;
        case 5:
          pedidosFaturar = data.map((json) => Pedido.fromJson(json)).toList();
          break;
        case 10:
          pedidosLogistica = data.map((json) => Pedido.fromJson(json)).toList();
          break;
        case 14:
          pedidosEmbalagem = data.map((json) => Pedido.fromJson(json)).toList();
          break;
        case 15:
          pedidosConferencia =
              data.map((json) => Pedido.fromJson(json)).toList();
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Pedido>> fetchOrdersBySituation(int idSituacao) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "id": idSituacao,
        },
      ),
    );

    try {
      List data = jsonDecode(response.body);
      return data.map((json) => Pedido.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<Pedido> fetchOrdersByIdOrder(int idPedido) async {
    var response = await http.post(
      Uri.parse('$url/Get'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "id": idPedido,
        },
      ),
    );

    try {
      return Pedido.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
