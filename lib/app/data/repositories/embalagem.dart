import 'dart:convert';

import '../../config/api_config.dart';
import '../../models/embalagem_model.dart';

import 'package:http/http.dart' as http;

class Embalagem {
  String url = '${ApiConfig().url}/Packaging';

  Future<List> fetchEmbalagens(int idPedido) async {
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
      List data = jsonDecode(response.body);
      return data
          .map(
            (json) => EmbalagemModel.fromJson(json),
          )
          .toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List> insertEmbalagem(EmbalagemModel embalagem) async {
    await http.post(
      Uri.parse('$url/Insert'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': embalagem.id,
          'idPedido': embalagem.idPedido,
          'idCaixa': embalagem.idCaixa,
          'quantidadeCaixa': embalagem.quantidadeCaixa,
          'pesoCaixa': embalagem.pesoCaixa,
          'observacoes': embalagem.observacoes,
        },
      ),
    );

    return fetchEmbalagens(
      int.parse(
        embalagem.idPedido.toString(),
      ),
    );
  }

  Future<List> updateEmbalagem(EmbalagemModel embalagem) async {
    await http.post(
      Uri.parse('$url/Update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': embalagem.id,
          'idPedido': embalagem.idPedido,
          'idCaixa': embalagem.idCaixa,
          'quantidadeCaixa': embalagem.quantidadeCaixa,
          'pesoCaixa': embalagem.pesoCaixa,
          'observacoes': embalagem.observacoes,
        },
      ),
    );

    return fetchEmbalagens(
      int.parse(
        embalagem.idPedido.toString(),
      ),
    );
  }

  Future<List> deleteEmbalagem(EmbalagemModel embalagem) async {
    await http.post(
      Uri.parse('$url/Delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': embalagem.id,
        },
      ),
    );

    return fetchEmbalagens(
      int.parse(
        embalagem.idPedido.toString(),
      ),
    );
  }
}
