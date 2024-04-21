import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/endereco_roteiro_entrega_model.dart';
import 'package:sgc/app/models/item_endereco_rota_model.dart';

class EnderecoRoteiroEntrega {
  String url = '${ApiConfig().url}/AdressOrderRoute';

  Future<List> fetchEnderecosRoteiro(int idRoteiro) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data
          .map((json) => EnderecoRoteiroEntregaModel.fromJson(json))
          .toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List> atualizarOrdem(int idRoteiro, List enderecos) async {
    if (enderecos.isNotEmpty) {
      int i = 0;

      for (var endereco in enderecos) {
        endereco.posicao = i;
        i++;
      }

      List jsonList = enderecos.map((endereco) => endereco.toJson()).toList();
      await http.post(
        Uri.parse('$url/Update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonList),
      );
    }

    return fetchEnderecosRoteiro(idRoteiro);
  }

  Future<List> entregarPedido(
    int idRoteiro,
    String cep,
    String numero,
    int idSituacao,
    int idCliente,
  ) async {
    await http.post(
      Uri.parse('$url/Deliver'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': 0,
          'entregue': idSituacao,
          'cep': cep,
          'numero': numero,
          'idRoteiro': idRoteiro,
          'idCliente': idCliente,
        },
      ),
    );

    return fetchEnderecosRoteiro(idRoteiro);
  }

  Future<List> fetchPedidos(String cep, String numero, int idRoteiro) async {
    var response = await http.post(
      Uri.parse('$url/GetOrders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'cep': cep,
          'numero': numero,
          'idRoteiro': idRoteiro,
        },
      ),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => ItemEnderecoRotaModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
