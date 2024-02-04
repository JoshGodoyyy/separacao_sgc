import 'dart:convert';

import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/models/vendedor_model.dart';
import 'package:http/http.dart' as http;

class VendedorDAO {
  String url = '${ApiConfig().url}/Seller';

  Future<VendedorModel> fetchVendedor(int id) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'id': int.parse(id.toString())},
      ),
    );

    try {
      return VendedorModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
