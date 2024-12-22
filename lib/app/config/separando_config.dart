import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeparandoConfig with ChangeNotifier {
  late SharedPreferences _preferences;

  static const String _keyMostrarEmbalagem = 'keyMostrarEmbalagem';
  static const String _keyMostrarConferencia = 'keyMostrarConferencia';
  static const String _keyMostrarFaturar = 'keyMostrarFaturar';
  static const String _keyMostrarLogistica = 'keyMostrarLogistica';

  bool _mostrarEmbalagem = true;
  bool _mostrarConferencia = true;
  bool _mostrarFaturar = true;
  bool _mostrarLogistica = true;

  bool get mostrarEmbalagem => _mostrarEmbalagem;
  bool get mostrarConferencia => _mostrarConferencia;
  bool get mostrarFaturar => _mostrarFaturar;
  bool get mostrarLogistica => _mostrarLogistica;

  SeparandoConfig() {
    _loadData();
  }

  void setEmbalagem(bool value) {
    _mostrarEmbalagem = value;
    _preferences.setBool(_keyMostrarEmbalagem, value);
    notifyListeners();
  }

  void setConferencia(bool value) {
    _mostrarConferencia = value;
    _preferences.setBool(_keyMostrarConferencia, value);
    notifyListeners();
  }

  void setFaturar(bool value) {
    _mostrarFaturar = value;
    _preferences.setBool(_keyMostrarFaturar, value);
    notifyListeners();
  }

  void setLogistica(bool value) {
    _mostrarLogistica = value;
    _preferences.setBool(_keyMostrarLogistica, value);
    notifyListeners();
  }

  Future<void> _loadData() async {
    _preferences = await SharedPreferences.getInstance();
    _mostrarEmbalagem = _preferences.getBool(_keyMostrarEmbalagem) ?? true;
    _mostrarConferencia = _preferences.getBool(_keyMostrarConferencia) ?? true;
    _mostrarFaturar = _preferences.getBool(_keyMostrarFaturar) ?? true;
    _mostrarLogistica = _preferences.getBool(_keyMostrarLogistica) ?? true;
    notifyListeners();
  }
}
