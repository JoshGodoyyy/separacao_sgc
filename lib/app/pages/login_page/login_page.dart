import 'package:flutter/material.dart';
import 'package:separacao_sgc/app/pages/loading_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '/app/pages/login_page/widgets/button.dart';
import '/app/pages/login_page/widgets/textfield.dart';

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

  void login() {
    if (usuarioController.text != 'Sr. Rafinha') {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
            message:
                'Usuário inválido. Tente utilizar \'Sr. Rafinha\' para realizar o login'),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (builder) => const LoadingScreen(),
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
                    'assets/images/logo.png',
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
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.info(
                          message: 'Feature em desenvolvimento!',
                        ),
                      );
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Button(
                onPressed: login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
