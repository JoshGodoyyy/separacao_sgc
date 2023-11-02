import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerFunction with ChangeNotifier {
  late SharedPreferences preferences;

  bool _accessories = true;
  bool _profiles = true;

  static const String _keyAccessories = 'keyAccessories';
  static const String _keyProfiles = 'keyProfiles';

  WorkerFunction() {
    _loadData();
  }

  bool get accessories => _accessories;
  bool get profiles => _profiles;

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

  Future<void> _loadData() async {
    preferences = await SharedPreferences.getInstance();
    _accessories = preferences.getBool(_keyAccessories) ?? true;
    _profiles = preferences.getBool(_keyProfiles) ?? true;
    notifyListeners();
  }
}
