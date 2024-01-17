import 'package:flutter/material.dart';
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/pages/initial_setup_page/initial_setup.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../ui/widgets/button.dart';
import '../../ui/widgets/textfield.dart';
import '../../data/user_dao.dart';
import '../../models/user_model.dart';
import '/app/pages/loading_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idLiberacaoController = TextEditingController();
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  void clear() {
    idLiberacaoController.clear();
    usuarioController.clear();
    senhaController.clear();
  }

  void login() async {
    final navigator = Navigator.of(context);
    final overlay = Overlay.of(context);

    await ApiConfig().getUrl();

    var user = User();
    user.user = usuarioController.text;
    user.password = senhaController.text;
    user.idLiberacao = idLiberacaoController.text;

    try {
      var response = await UserDAO().auth(user);

      if (response) {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (builder) => const LoadingScreen(),
          ),
        );
      }
    } catch (e) {
      String message = '';
      if (e.toString().startsWith('Exception')) {
        message = e.toString().substring(11);
      } else {
        message = e.toString();
      }
      showTopSnackBar(
        overlay,
        CustomSnackBar.error(
          message: message,
        ),
      );
    }

    clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12111F),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logo_light.png',
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
                STextField(
                  controller: idLiberacaoController,
                  label: 'Chave de Acesso',
                  usePasswordChar: true,
                ),
                STextField(
                  controller: usuarioController,
                  label: 'Usuário',
                  usePasswordChar: false,
                ),
                STextField(
                  controller: senhaController,
                  label: 'Senha',
                  usePasswordChar: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        const Text('Salvar login'),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => const InitialSetup(),
                        ),
                      ),
                      child: const Text(
                        'Configurar acesso',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Button(
                    label: 'Entrar',
                    onPressed: login,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
