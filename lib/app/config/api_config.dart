import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();

  factory ApiConfig() {
    return _instance;
  }

  ApiConfig._internal();

  late String _url;

  String get url => _url;

  Future<void> getUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String response = preferences.getString('url') ?? '';
    if (response.endsWith('/')) {
      _url = response.substring(0, response.length - 1);
    } else {
      _url = response;
    }
  }

  setUrl(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _url = value;
    preferences.setString('url', value);
  }
}
