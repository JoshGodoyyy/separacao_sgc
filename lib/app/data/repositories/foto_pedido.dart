import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';

class FotoPedido {
  final String _url = '${ApiConfig().url}/OrderPhoto';

  Future<List<dynamic>> fetchFotos(FotoPedidoModel foto) async {
    var response = await http.post(
      Uri.parse('$_url/GetPhotos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': int.parse(foto.id.toString()),
          'idRoteiro': int.parse(foto.idRoteiro.toString()),
          'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
          'idPedido': int.parse(foto.idPedido.toString()),
          'imagem': foto.imagem,
          'descricao': foto.descricao,
          'dataFoto': foto.dataFoto,
        },
      ),
    );

    try {
      if (response.body.isEmpty) return [];
      var data = jsonDecode(response.body);
      return data.map((json) => FotoPedidoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future insert(FotoPedidoModel foto) async {
    await http.post(
      Uri.parse('$_url/InsertPhoto'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': int.parse(foto.id.toString()),
          'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
          'idPedido': int.parse(foto.idPedido.toString()),
          'idRoteiro': int.parse(foto.idRoteiro.toString()),
          'imagem': foto.imagem,
          'descricao': foto.descricao,
          'dataFoto': foto.dataFoto,
        },
      ),
    );
  }

  Future<List<dynamic>> delete(FotoPedidoModel foto) async {
    await http.delete(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': int.parse(foto.id.toString()),
          'situacaoFoto': int.parse(foto.situacaoFoto.toString()),
          'idPedido': int.parse(foto.idPedido.toString()),
          'idRoteiro': int.parse(foto.idRoteiro.toString()),
          'imagem': foto.imagem,
          'descricao': foto.descricao,
          'dataFoto': foto.dataFoto,
        },
      ),
    );

    return fetchFotos(foto);
  }
}
