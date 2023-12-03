import 'dart:convert';

import 'package:sgc/app/models/tratamento_model.dart';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class Tratamento {
  String url = '${ApiConfig().url}/Treatment';

  Future<List<TratamentoModel>> fetchTratamento() async {
    final response = await http.get(Uri.parse(url));

    try {
      var data = jsonDecode(response.body);
      return List<TratamentoModel>.from(
        data.map(
          (item) => TratamentoModel.fromJson(item),
        ),
      );
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<TratamentoModel> fetchTratamentoById(String id) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
      }),
    );

    try {
      var obj = TratamentoModel.fromJson(
        jsonDecode(response.body),
      );
      return obj;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
