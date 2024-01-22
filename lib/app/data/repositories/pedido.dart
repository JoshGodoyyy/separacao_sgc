import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../models/pedido_model.dart';

class Pedido with ChangeNotifier {
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
          'id': idSituacao,
        },
      ),
    );

    try {
      List data = jsonDecode(response.body);

      switch (idSituacao) {
        case 2:
          pedidosSeparar = data
              .map(
                (json) => PedidoModel.fromJson(json),
              )
              .toList();
          break;
        case 3:
          pedidosSeparando = data
              .map(
                (json) => PedidoModel.fromJson(json),
              )
              .toList();
          break;
        case 5:
          pedidosFaturar = data
              .map(
                (json) => PedidoModel.fromJson(json),
              )
              .toList();
          break;
        case 10:
          pedidosLogistica = data
              .map(
                (json) => PedidoModel.fromJson(json),
              )
              .toList();
          break;
        case 14:
          pedidosEmbalagem = data
              .map(
                (json) => PedidoModel.fromJson(json),
              )
              .toList();
          break;
        case 15:
          pedidosConferencia =
              data.map((json) => PedidoModel.fromJson(json)).toList();
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PedidoModel>> fetchOrdersBySituation(
      {required int idSituacao, int? idPedido}) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idSituacao,
          'idPedido': idPedido,
        },
      ),
    );

    try {
      List data = jsonDecode(response.body);
      return data.map((json) => PedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<PedidoModel> fetchOrdersByIdOrder(int idPedido) async {
    var response = await http.post(
      Uri.parse('$url/Get'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idPedido,
        },
      ),
    );

    try {
      return PedidoModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<int> getSeparacao(int idPedido, String tipoSeparacao) async {
    var response = await http.post(
      Uri.parse('$url/Get/Separation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'idPedido': idPedido,
          'tipoSeparacao': tipoSeparacao,
        },
      ),
    );

    try {
      final int data = json.decode(response.body);
      return data;
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future<PedidoModel> enviarSeparacao(
    int idSituacao,
    String dataLiberacaoSeparacao,
    String dataEnvioSeparacao,
    String idIniciarSeparacao,
    int sepAcessorio,
    int sepPerfil,
    int id,
  ) async {
    await http.post(
      Uri.parse('$url/SendToSeparation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': id,
          'idSituacao': idSituacao,
          'dataLiberacaoSeparacao': dataLiberacaoSeparacao,
          'dataEnvioSeparacao': dataEnvioSeparacao,
          'idIniciarSeparacao': idIniciarSeparacao,
          'sepAcessorio': sepAcessorio,
          'sepPerfil': sepPerfil,
          'dataRetornoSeparacao': '',
          'observacoesSeparacao': '',
          'idConcluirSeparacao': '',
        },
      ),
    );

    return fetchOrdersByIdOrder(
      id,
    );
  }

  Future<PedidoModel> enviarEmbalagem(
    int idSituacao,
    int sepAcessorio,
    int sepPerfil,
    int idSeparador,
    String dataRetornoSeparacao,
    String observacoesSeparacao,
    String idConcluirSeparacao,
    int id,
  ) async {
    await http.post(
      Uri.parse('$url/SendToPackaging'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': id,
          'idSituacao': idSituacao,
          'dataLiberacaoSeparacao': '',
          'dataEnvioSeparacao': '',
          'idIniciarSeparacao': '',
          'idSeparador': idSeparador,
          'sepAcessorio': sepAcessorio,
          'sepPerfil': sepPerfil,
          'dataRetornoSeparacao': dataRetornoSeparacao,
          'observacoesSeparacao': observacoesSeparacao,
          'idConcluirSeparacao': idConcluirSeparacao,
        },
      ),
    );

    return fetchOrdersByIdOrder(
      id,
    );
  }

  Future<PedidoModel> updateOrder(
    int idPedido,
    double volAcessorio,
    double volAlum,
    double volChapa,
    String obsSeparacao,
    String obsSeparador,
    String setorEstoque,
    double pesoAcessorio,
  ) async {
    await http.post(
      Uri.parse('$url/Update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'volumeAcessorio': volAcessorio,
          'volumeAluminio': volAlum,
          'volumeChapa': volChapa,
          'observacoesSeparacao': obsSeparacao,
          'observacoesSeparador': obsSeparador,
          'setorSeparacao': setorEstoque,
          'pesoAcessorio': pesoAcessorio,
          'idPedido': idPedido,
        },
      ),
    );

    return fetchOrdersByIdOrder(
      idPedido,
    );
  }
}
