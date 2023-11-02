import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Widgets with ChangeNotifier {
  late SharedPreferences preferences;

  bool _separar = true;
  bool _separando = true;
  bool _embalagem = true;
  bool _conferencia = true;
  bool _faturar = true;
  bool _logistica = true;

  static const String _keySeparar = 'keySeparar';
  static const String _keySeparando = 'keySeparando';
  static const String _keyEmbalagem = 'keyEmbalagem';
  static const String _keyConferencia = 'keyConferencia';
  static const String _keyFaturar = 'keyFaturar';
  static const String _keyLogistica = 'keyLogistica';

  Widgets() {
    _loadData();
  }

  bool get separar => _separar;
  bool get separando => _separando;
  bool get embalagem => _embalagem;
  bool get conferencia => _conferencia;
  bool get faturar => _faturar;
  bool get logistica => _logistica;

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
    _separar = preferences.getBool(_keySeparar) ?? true;
    _separando = preferences.getBool(_keySeparando) ?? true;
    _embalagem = preferences.getBool(_keyEmbalagem) ?? true;
    _conferencia = preferences.getBool(_keyConferencia) ?? true;
    _faturar = preferences.getBool(_keyFaturar) ?? true;
    _logistica = preferences.getBool(_keyLogistica) ?? true;
    notifyListeners();
  }
}
