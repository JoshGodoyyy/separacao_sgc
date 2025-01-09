import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/empresa_model.dart';

class Empresa {
  final String _url = '${ApiConfig().url}/Company';

  Future fetchEmpresa(int id) async {
    try {
      var response = await http.post(
        Uri.parse('$_url/GetCompany'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(id),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return EmpresaModel.fromJson(data);
      }

      throw Exception(response.statusCode);
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }
}
