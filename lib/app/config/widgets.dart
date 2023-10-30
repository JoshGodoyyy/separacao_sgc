import 'package:flutter/material.dart';

class Widgets with ChangeNotifier {
  bool _separar = true;
  bool _separando = true;
  bool _embalagem = true;
  bool _conferencia = true;
  bool _faturar = true;
  bool _logistica = true;

  static final Widgets _instance = Widgets._internal();

  factory Widgets() {
    return _instance;
  }

  Widgets._internal();

  bool get separar => _separar;
  bool get separando => _separando;
  bool get embalagem => _embalagem;
  bool get conferencia => _conferencia;
  bool get faturar => _faturar;
  bool get logistica => _logistica;

  void setSeparar(bool value) {
    _separar = value;
    notifyListeners();
  }

  void setSeparando(bool value) {
    _separando = value;
    notifyListeners();
  }

  void setEmbalagem(bool value) {
    _embalagem = value;
    notifyListeners();
  }

  void setConferencia(bool value) {
    _conferencia = value;
    notifyListeners();
  }

  void setFaturar(bool value) {
    _faturar = value;
    notifyListeners();
  }

  void setLogistica(bool value) {
    _logistica = value;
    notifyListeners();
  }
}
