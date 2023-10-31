import 'package:flutter/material.dart';

class WorkerFunction with ChangeNotifier {
  bool _accessories = true;
  bool _profiles = true;

  static final WorkerFunction _instance = WorkerFunction._internal();

  factory WorkerFunction() {
    return _instance;
  }

  WorkerFunction._internal();

  bool get accessories => _accessories;
  bool get profiles => _profiles;

  void setAccessories(bool value) {
    _accessories = value;
    notifyListeners();
  }

  void setProfiles(bool value) {
    _profiles = value;
    notifyListeners();
  }
}
