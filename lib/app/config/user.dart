class UserConstants {
  static final UserConstants _user = UserConstants._internal();

  factory UserConstants() {
    return _user;
  }

  UserConstants._internal();

  String? _userName;
  String? _idLiberacao;

  String? get userName => _userName;
  String? get idLiberacao => _idLiberacao;

  void setUserName(String name) {
    _userName = name;
  }

  void setIdLiberacao(String id) {
    _idLiberacao = id;
  }
}
