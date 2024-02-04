import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:sgc/app/config/configuracoes_sistema.dart';

class Configuracoes {
  final String _url = '${ApiConfig().url}/Settings';

  Future<void> verificaFechamentoPedAntSeparacao() async {
    var response = await http.get(
      Uri.parse(_url),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    int value = data["fechamentoPedAntSeparacao"];

    ConfiguracoesSistema().setFechamento(value);
  }
}
