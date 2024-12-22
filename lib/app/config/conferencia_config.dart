import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConferenciaConfig with ChangeNotifier {
  late SharedPreferences _preferences;

  static const String _keyMostrarEmbalagem = 'keyMostrarEmbalagemConferencia';
  static const String _keyMostrarFaturar = 'keyMostrarFaturarConferencia';
  static const String _keyMostrarLogistica = 'keyMostrarLogisticaConferencia';

  bool _mostrarEmbalagem = true;
  bool _mostrarFaturar = true;
  bool _mostrarLogistica = true;

  bool get mostrarEmbalagem => _mostrarEmbalagem;
  bool get mostrarFaturar => _mostrarFaturar;
  bool get mostrarLogistica => _mostrarLogistica;

  ConferenciaConfig() {
    _loadData();
  }

  void setEmbalagem(bool value) {
    _mostrarEmbalagem = value;
    _preferences.setBool(_keyMostrarEmbalagem, value);
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
    _mostrarFaturar = _preferences.getBool(_keyMostrarFaturar) ?? true;
    _mostrarLogistica = _preferences.getBool(_keyMostrarLogistica) ?? true;
    notifyListeners();
  }
}
