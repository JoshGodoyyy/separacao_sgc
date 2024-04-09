import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

class RoteiroEntrega {
  String url = '${ApiConfig().url}/DeliveryRoute';

  Future<List> fetchRoteiros() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => RoteiroEntregaModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List> concluirCarregamento(int idRoteiro) async {
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
        },
      ),
    );
    return fetchRoteiros();
  }

  Future fetchDados(int idRoteiro) async {
    var response = await http.post(
      Uri.parse('$url/GetData'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
        },
      ),
    );

    try {
      return RoteiroEntregaModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateDados(int idRoteiro, double kmInicial, String ajudante,
      String horarioSaida) async {
    await http.post(
      Uri.parse('$url/UpdateData'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
          'ajudante': ajudante,
          'kmInicial': kmInicial,
          'horaSaida': horarioSaida,
        },
      ),
    );

    return fetchDados(idRoteiro);
  }

  Future finishDados(
    int idRoteiro,
    double pedagio,
    double combustivel,
    double refeicao,
    double kmFinal,
  ) async {
    await http.post(
      Uri.parse('$url/FinishData'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idRoteiro,
          'pedagio': pedagio,
          'combustivel': combustivel,
          'refeicao': refeicao,
          'kmFinal': kmFinal,
        },
      ),
    );

    return fetchDados(idRoteiro);
  }
}
