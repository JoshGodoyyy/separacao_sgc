import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/produto_model.dart';
import 'package:http/http.dart' as http;

class Produto {
  String url = '${ApiConfig().url}/Product';

  Future<List<dynamic>> fetchProdutos(
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
    int idPedido,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'visualizarPerfil': perfis,
        'visualizarAcessorio': acessorios,
        'visualizarVidro': vidros,
        'visualizarChapa': chapas,
        'visualizarKit': kits,
        'idPedido': idPedido,
      }),
    );

    try {
      var data = jsonDecode(response.body);
      return data.map((json) => ProdutoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<int> getTotalProdutos(
    int idPedido,
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$url/TotalProdutos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'idPedido': idPedido,
          'visualizarPerfil': perfis,
          'visualizarAcessorio': acessorios,
          'visualizarVidro': vidros,
          'visualizarChapa': chapas,
          'visualizarKit': kits,
        }),
      );

      if (response.statusCode == 200) {
        return int.parse(response.body);
      }

      throw Exception(response.statusCode);
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future<List<dynamic>> updateProduto(
    int idProduto,
    int separado,
    int idPedido,
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateSeparado'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': separado,
        },
      ),
    );

    return fetchProdutos(perfis, acessorios, chapas, vidros, kits, idPedido);
  }

  Future<List<dynamic>> updateEmbalado(
    int idProduto,
    int embalado,
    int idPedido,
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateEmbalagem'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': embalado,
        },
      ),
    );

    return fetchProdutos(perfis, acessorios, chapas, vidros, kits, idPedido);
  }

  Future<List<dynamic>> updateConferido(
    int idProduto,
    int conferido,
    int idPedido,
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
  ) async {
    await http.post(
      Uri.parse('$url/UpdateConferido'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'id': idProduto,
          'valor': conferido,
        },
      ),
    );

    return fetchProdutos(perfis, acessorios, chapas, vidros, kits, idPedido);
  }
}
