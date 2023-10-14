import '../models/login_model.dart';

class LoginDAO {
  bool auth(LoginModel user) {
    if (user.user != 'Sr. Rafinha') {
      throw Exception(
          'Usuário inválido. Tente utilizar \'Sr. Rafinha\' para realizar o login');
    } else {
      return true;
    }
  }
}
