import 'package:flutter/material.dart';

class MenuState extends ChangeNotifier {
  bool _aberto = false;

  bool get aberto => _aberto;

  void setEstado(bool value) {
    _aberto = value;
    notifyListeners();
  }
}
