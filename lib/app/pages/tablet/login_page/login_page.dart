import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/repositories/configuracoes.dart';
import 'package:sgc/app/pages/tablet/home_page/home_page.dart';
import '../../../config/api_config.dart';
import '../../../config/app_config.dart';
import '../../../config/secure_storage.dart';
import '../../../data/enums/icones.dart';
import '../../../data/repositories/user_dao.dart';
import '../../../models/user_model.dart';
import '../../../ui/widgets/button.dart';
import '../../../ui/widgets/custom_dialog.dart';
import '../../../ui/widgets/textfield.dart';
import '../../initial_setup_page/initial_setup.dart';

class TLoginPage extends StatefulWidget {
  const TLoginPage({super.key});

  @override
  State<TLoginPage> createState() => _TLoginPageState();
}

class _TLoginPageState extends State<TLoginPage> {
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
  }

  void login() async {
    final config = Provider.of<AppConfig>(context, listen: false);
    final navigator = Navigator.of(context);

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
            builder: (builder) => const THomePage(),
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

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: Row(
                  children: [
                    Text(message),
                  ],
                ),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );
        },
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
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logo_light.png',
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                            const Text(
                              'Salvar login',
                              style: TextStyle(color: Colors.white),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
