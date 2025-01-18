import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/models/group_model.dart';

import '../../config/api_config.dart';

class Grupo {
  String url = '${ApiConfig().url}/Group';

  Future<List<dynamic>> fetchGrupos(
    int idPedido,
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'idPedido': idPedido,
          'visualizarPerfil': perfis,
          'visualizarAcessorio': acessorios,
          'visualizarVidro': vidros,
          'visualizarChapa': chapas,
          'visualizarKit': kits,
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
    bool perfis,
    bool acessorios,
    bool chapas,
    bool vidros,
    bool kits,
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

    return fetchGrupos(idPedido, perfis, acessorios, chapas, vidros, kits);
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
