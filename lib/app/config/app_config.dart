import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig with ChangeNotifier {
  late SharedPreferences preferences;

  static const String _keySalvarDados = 'keySalvarDados';

  static const String _keyTheme = 'keyDarkMode';

  static const String _keyAccessories = 'keyAccessories';
  static const String _keyProfiles = 'keyProfiles';
  static const String _keyVidros = 'keyVidros';
  static const String _keyChapas = 'keyChapas';
  static const String _keyKits = 'keyKits';

  static const String _keySeparar = 'keySeparar';
  static const String _keySeparando = 'keySeparando';
  static const String _keyEmbalagem = 'keyEmbalagem';
  static const String _keyConferencia = 'keyConferencia';
  static const String _keyFaturar = 'keyFaturar';
  static const String _keyLogistica = 'keyLogistica';

  static const String _keyBalcao = 'keyBalcao';
  static const String _keyRetirar = 'keyRetirar';

  static const String _keyPrinterIP = 'keyPrinterIP';
  static const String _keyPrinterPort = 'keyPrinterPort';

  bool _salvarDados = false;

  bool _isDarkMode = false;

  bool _accessories = true;
  bool _profiles = true;
  bool _vidros = true;
  bool _chapas = true;
  bool _kits = true;

  bool _separar = true;
  bool _separando = true;
  bool _embalagem = true;
  bool _conferencia = true;
  bool _faturar = true;
  bool _logistica = true;

  bool _balcao = true;
  bool _retirar = true;

  String _printerIp = '';
  String _printerPort = '';

  AppConfig() {
    _loadData();
  }

  bool get salvarDados => _salvarDados;

  bool get isDarkMode => _isDarkMode;

  bool get accessories => _accessories;
  bool get profiles => _profiles;
  bool get vidros => _vidros;
  bool get chapas => _chapas;
  bool get kits => _kits;

  bool get separar => _separar;
  bool get separando => _separando;
  bool get embalagem => _embalagem;
  bool get conferencia => _conferencia;
  bool get faturar => _faturar;
  bool get logistica => _logistica;

  bool get balcao => _balcao;
  bool get retirar => _retirar;

  String get printerIp => _printerIp;
  String get printerPort => _printerPort;

  void setSalvarDados(bool value) {
    _salvarDados = value;
    preferences.setBool(_keySalvarDados, value);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    preferences.setBool(_keyTheme, _isDarkMode);
    notifyListeners();
  }

  void setAccessories(bool value) {
    _accessories = value;
    preferences.setBool(_keyAccessories, value);
    notifyListeners();
  }

  void setProfiles(bool value) {
    _profiles = value;
    preferences.setBool(_keyProfiles, value);
    notifyListeners();
  }

  void setVidros(bool value) {
    _vidros = value;
    preferences.setBool(_keyVidros, value);
    notifyListeners();
  }

  void setChapas(bool value) {
    _chapas = value;
    preferences.setBool(_keyChapas, value);
    notifyListeners();
  }

  void setKits(bool value) {
    _kits = value;
    preferences.setBool(_keyKits, value);
    notifyListeners();
  }

  void setSeparar(bool value) {
    _separar = value;
    preferences.setBool(_keySeparar, _separar);
    notifyListeners();
  }

  void setSeparando(bool value) {
    _separando = value;
    preferences.setBool(_keySeparando, _separando);
    notifyListeners();
  }

  void setEmbalagem(bool value) {
    _embalagem = value;
    preferences.setBool(_keyEmbalagem, _embalagem);
    notifyListeners();
  }

  void setConferencia(bool value) {
    _conferencia = value;
    preferences.setBool(_keyConferencia, _conferencia);
    notifyListeners();
  }

  void setFaturar(bool value) {
    _faturar = value;
    preferences.setBool(_keyFaturar, _faturar);
    notifyListeners();
  }

  void setLogistica(bool value) {
    _logistica = value;
    preferences.setBool(_keyLogistica, _logistica);
    notifyListeners();
  }

  void setBalcao(bool value) {
    _balcao = value;
    preferences.setBool(_keyBalcao, _balcao);
    notifyListeners();
  }

  void setRetirar(bool value) {
    _retirar = value;
    preferences.setBool(_keyRetirar, _retirar);
    notifyListeners();
  }

  void setPrinterIp(String value) {
    _printerIp = value;
    preferences.setString(_keyPrinterIP, value);
  }

  void setPrinterPort(String value) {
    _printerPort = value;
    preferences.setString(_keyPrinterPort, value);
  }

  Future<void> _loadData() async {
    preferences = await SharedPreferences.getInstance();
    _salvarDados = preferences.getBool(_keySalvarDados) ?? false;

    _isDarkMode = preferences.getBool(_keyTheme) ?? false;

    _accessories = preferences.getBool(_keyAccessories) ?? true;
    _profiles = preferences.getBool(_keyProfiles) ?? true;
    _vidros = preferences.getBool(_keyVidros) ?? true;
    _chapas = preferences.getBool(_keyChapas) ?? true;
    _kits = preferences.getBool(_keyKits) ?? true;

    _separar = preferences.getBool(_keySeparar) ?? true;
    _separando = preferences.getBool(_keySeparando) ?? true;
    _embalagem = preferences.getBool(_keyEmbalagem) ?? true;
    _conferencia = preferences.getBool(_keyConferencia) ?? true;
    _faturar = preferences.getBool(_keyFaturar) ?? true;
    _logistica = preferences.getBool(_keyLogistica) ?? true;

    _balcao = preferences.getBool(_keyBalcao) ?? true;
    _retirar = preferences.getBool(_keyRetirar) ?? true;

    _printerIp = preferences.getString(_keyPrinterIP) ?? '';
    _printerPort = preferences.getString(_keyPrinterPort) ?? '';
    notifyListeners();
  }
}
