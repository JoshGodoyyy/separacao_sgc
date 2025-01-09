import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmbalagemConfig with ChangeNotifier {
  late SharedPreferences _preferences;

  static const String _keyMostrarConferencia = 'keyMostrarConferenciaEmbalagem';
  static const String _keyMostrarFaturar = 'keyMostrarFaturarEmbalagem';

  bool _mostrarConferencia = true;
  bool _mostrarFaturar = true;

  bool get mostrarConferencia => _mostrarConferencia;
  bool get mostrarFaturar => _mostrarFaturar;

  EmbalagemConfig() {
    _loadData();
  }

  void setEmbalagem(bool value) {
    _mostrarConferencia = value;
    _preferences.setBool(_keyMostrarConferencia, value);
    notifyListeners();
  }

  void setFaturar(bool value) {
    _mostrarFaturar = value;
    _preferences.setBool(_keyMostrarFaturar, value);
    notifyListeners();
  }

  Future<void> _loadData() async {
    _preferences = await SharedPreferences.getInstance();
    _mostrarConferencia = _preferences.getBool(_keyMostrarConferencia) ?? true;
    _mostrarFaturar = _preferences.getBool(_keyMostrarFaturar) ?? true;
    notifyListeners();
  }
}
