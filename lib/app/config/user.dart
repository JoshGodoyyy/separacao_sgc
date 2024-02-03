import '../models/user_model.dart';

class UserConstants {
  static final UserConstants _user = UserConstants._internal();

  factory UserConstants() {
    return _user;
  }

  UserConstants._internal();

  int? _idUsuario;
  String? _userName;
  String? _idLiberacao;

  int? get idUsuario => _idUsuario;
  String? get userName => _userName;
  String? get idLiberacao => _idLiberacao;

  void setUserData(User usuario) {
    _idUsuario = int.parse(
      usuario.id.toString(),
    );
    _userName = usuario.apelido;
    _idLiberacao = usuario.idLiberacao;
  }
}
