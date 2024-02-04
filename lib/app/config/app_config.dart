import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig with ChangeNotifier {
  late SharedPreferences preferences;

  static const String _keySalvarDados = 'keySalvarDados';
  static const String _keyTheme = 'keyDarkMode';
  static const String _keyAccessories = 'keyAccessories';
  static const String _keyProfiles = 'keyProfiles';
  static const String _keySeparar = 'keySeparar';
  static const String _keySeparando = 'keySeparando';
  static const String _keyEmbalagem = 'keyEmbalagem';
  static const String _keyConferencia = 'keyConferencia';
  static const String _keyFaturar = 'keyFaturar';
  static const String _keyLogistica = 'keyLogistica';

  bool _salvarDados = false;
  bool _isDarkMode = false;
  bool _accessories = true;
  bool _profiles = true;
  bool _separar = true;
  bool _separando = true;
  bool _embalagem = true;
  bool _conferencia = true;
  bool _faturar = true;
  bool _logistica = true;

  AppConfig() {
    _loadData();
  }

  bool get salvarDados => _salvarDados;
  bool get isDarkMode => _isDarkMode;
  bool get accessories => _accessories;
  bool get profiles => _profiles;
  bool get separar => _separar;
  bool get separando => _separando;
  bool get embalagem => _embalagem;
  bool get conferencia => _conferencia;
  bool get faturar => _faturar;
  bool get logistica => _logistica;

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

  Future<void> _loadData() async {
    preferences = await SharedPreferences.getInstance();
    _salvarDados = preferences.getBool(_keySalvarDados) ?? false;
    _isDarkMode = preferences.getBool(_keyTheme) ?? false;
    _accessories = preferences.getBool(_keyAccessories) ?? true;
    _profiles = preferences.getBool(_keyProfiles) ?? true;
    _separar = preferences.getBool(_keySeparar) ?? true;
    _separando = preferences.getBool(_keySeparando) ?? true;
    _embalagem = preferences.getBool(_keyEmbalagem) ?? true;
    _conferencia = preferences.getBool(_keyConferencia) ?? true;
    _faturar = preferences.getBool(_keyFaturar) ?? true;
    _logistica = preferences.getBool(_keyLogistica) ?? true;
    notifyListeners();
  }
}
