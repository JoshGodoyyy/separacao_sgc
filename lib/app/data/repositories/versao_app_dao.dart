import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/versao_app.dart';

class VersaoAppDao {
  final String _url = '${ApiConfig().url}/AppVersion';

  Future<VersaoApp> fetchVersion() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
    );

    try {
      return VersaoApp.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
