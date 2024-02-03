import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/models/group_model.dart';

import '../../config/api_config.dart';

class Grupo {
  String url = '${ApiConfig().url}/Group';

  Future<List<dynamic>> fetchGrupos(int idPedido, int tipoProduto) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'idPedido': idPedido,
          'tipoProduto': tipoProduto,
        },
      ),
    );

    try {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        return data.map((json) => GrupoModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<List<dynamic>> updateGrupo(
    GrupoModel grupo,
    int idPedido,
    int tipoProduto,
  ) async {
    try {
      await http.post(
        Uri.parse('$url/Update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'id': grupo.id,
            'idGrupo': grupo.idGrupo,
            'descricao': grupo.descricao,
            'pesoTeorico': grupo.pesoTeorico,
            'pesoReal': grupo.pesoReal,
            'valorGrupo': grupo.valorGrupo,
            'valorReal': grupo.valorReal,
            'separado': grupo.separado,
            'juros': grupo.juros,
            'difal': grupo.difal,
          },
        ),
      );
    } catch (ex) {
      throw Exception(ex.toString());
    }

    return fetchGrupos(idPedido, tipoProduto);
  }

  Future<void> atualizarGruposPedidos(List grupos, List produtos) async {
    await http.post(
      Uri.parse('$url/Update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'groups': grupos,
        'products': produtos,
      }),
    );
  }
}
