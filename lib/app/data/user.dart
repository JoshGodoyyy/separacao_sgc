class User {
  static final User _user = User._internal();

  factory User() {
    return _user;
  }

  User._internal();

  String? _userName;

  String? get userName => _userName;

  void setUserName(String name) {
    _userName = name;
  }
}
