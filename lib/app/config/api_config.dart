import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();

  factory ApiConfig() {
    return _instance;
  }

  ApiConfig._internal();

  String? _url;

  String? get url => _url;

  Future<void> getUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _url = preferences.getString('url') ?? '';
  }

  setUrl(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _url = value;
    preferences.setString('url', value);
  }
}
