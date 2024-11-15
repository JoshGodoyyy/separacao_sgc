import 'package:sgc/app/models/url_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();

  factory ApiConfig() {
    return _instance;
  }

  ApiConfig._internal();

  late String _url;
  late List<UrlApiModel> _urls;

  String get url => _url;
  List<UrlApiModel> get urls => _urls;

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

  saveData(List<UrlApiModel> json) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String encodedData = UrlApiModel.encode(json);
    await preferences.setString('urls', encodedData);
  }

  Future<void> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String item = preferences.getString('urls') ?? '';
    _urls = UrlApiModel.decode(item);
  }
}
