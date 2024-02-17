import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/config/secure_storage.dart';
import 'package:sgc/app/data/repositories/configuracoes.dart';
import 'package:sgc/app/pages/initial_setup_page/initial_setup.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../config/app_config.dart';
import '../../ui/widgets/button.dart';
import '../../ui/widgets/textfield.dart';
import '../../data/repositories/user_dao.dart';
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
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    idLiberacaoController.text = await SecureStorage().ler('chave');
    usuarioController.text = await SecureStorage().ler('usuario');
    senhaController.text = await SecureStorage().ler('senha');
  }

  void clear() {
    idLiberacaoController.clear();
    usuarioController.clear();
    senhaController.clear();
  }

  void login() async {
    final config = Provider.of<AppConfig>(context, listen: false);
    final navigator = Navigator.of(context);
    final overlay = Overlay.of(context);

    if (idLiberacaoController.text.trim() == '') {
      showTopSnackBar(
        overlay,
        const CustomSnackBar.error(
          message: 'Chave de acesso obrigatória',
        ),
      );

      return;
    }

    setState(() => isWaiting = true);

    await ApiConfig().getUrl();

    var user = User();
    user.user = usuarioController.text;
    user.password = senhaController.text;
    user.idLiberacao = idLiberacaoController.text;

    try {
      var response = await UserDAO().auth(user);

      if (response) {
        await Configuracoes().verificaFechamentoPedAntSeparacao();

        if (config.salvarDados) {
          SecureStorage().salvar('chave', idLiberacaoController.text);
          SecureStorage().salvar('usuario', usuarioController.text);
          SecureStorage().salvar('senha', senhaController.text);
        } else {
          SecureStorage().apagar('chave');
          SecureStorage().apagar('usuario');
          SecureStorage().apagar('senha');
        }

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

    setState(() => isWaiting = false);
    clear();
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<AppConfig>(context);

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
                        Checkbox(
                          value: config.salvarDados,
                          onChanged: (value) {
                            config.setSalvarDados(!config.salvarDados);
                          },
                        ),
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
                    onPressed: isWaiting ? () {} : login,
                  ),
                ),
                const SizedBox(height: 64),
                Visibility(
                  visible: isWaiting,
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Colors.white,
                      size: 50,
                    ),
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
