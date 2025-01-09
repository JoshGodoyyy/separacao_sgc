import 'package:http/http.dart' as http;
import 'package:sgc/app/config/api_config.dart';

class Impressora {
  final String _url = '${ApiConfig().url}/Printer';

  Future<String> fetchZpl() async {
    try {
      var response = await http.get(
        Uri.parse('$_url/GetZpl'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return response.body;
      }

      return '${response.statusCode}';
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }
}
