class UserConstants {
  static final UserConstants _user = UserConstants._internal();

  factory UserConstants() {
    return _user;
  }

  UserConstants._internal();

  String? _userName;

  String? get userName => _userName;

  void setUserName(String name) {
    _userName = name;
  }
}
