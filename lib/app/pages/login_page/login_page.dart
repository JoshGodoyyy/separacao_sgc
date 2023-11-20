import 'package:flutter/material.dart';
import 'package:sgc/app/pages/initial_setup_page/initial_setup.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ui/widgets/button.dart';
import '../../ui/widgets/textfield.dart';
import '/app/data/login_dao.dart';
import '/app/models/login_model.dart';
import '/app/pages/loading_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  void clear() {
    usuarioController.clear();
    senhaController.clear();
  }

  void login() async {
    final navigator = Navigator.of(context);

    var user = LoginModel(
      user: usuarioController.text.trim(),
      password: senhaController.text,
    );

    try {
      var response = await LoginDAO().auth(user);

      if (response) {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (builder) => const LoadingScreen(),
          ),
        );
      }
    } catch (e) {
      String message = e.toString().substring(11);
      showTopSnackBar(
        Overlay.of(context),
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
                controller: usuarioController,
                label: 'Usuário',
                usePasswordChar: false,
              ),
              STextField(
                controller: senhaController,
                label: 'Senha',
                usePasswordChar: true,
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (builder) => const InitialSetup(),
                      ),
                    )
                    .then(
                      (value) => setState(
                        () {},
                      ),
                    ),
                child: const Text(
                  'Configurar acesso',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
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
    );
  }
}
