import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/config/secure_storage.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/repositories/configuracoes.dart';
import 'package:sgc/app/data/repositories/versao_app_dao.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:version/version.dart';

import '../../../config/app_config.dart';
import '../../../data/repositories/user_dao.dart';
import '../../../models/user_model.dart';
import '../../../ui/widgets/button.dart';
import '../../../ui/widgets/textfield.dart';
import '../../initial_setup_page/initial_setup.dart';
import '../loading_screen.dart';

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
  bool _atualizado = false;

  String _version = '';
  List<int> _currentVersion = [];
  List<int> _requiredVersion = [];

  @override
  void initState() {
    super.initState();
    _loadVersion();
    loadData();
  }

  _loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(
      () => _version = '${packageInfo.version}+${packageInfo.buildNumber}',
    );

    _currentVersion = packageInfo.version.split('.').map(int.parse).toList();
  }

  _getVersion() async {
    await ApiConfig().getUrl();

    if (ApiConfig().url == '') {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Wrap(
                  children: [
                    Text(
                      'É necessário indicar o endereço da API antes de continuar',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ],
                ),
                tipo: Icones.info,
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

      return;
    }

    var responseVersion = await VersaoAppDao().fetchVersion();

    _requiredVersion = [
      int.parse(
        responseVersion.major.toString(),
      ),
      int.parse(
        responseVersion.minor.toString(),
      ),
      int.parse(
        responseVersion.patch.toString(),
      ),
    ];

    Version current = Version(
      _currentVersion[0],
      _currentVersion[1],
      _currentVersion[2],
    );

    Version latest = Version(
      _requiredVersion[0],
      _requiredVersion[1],
      _requiredVersion[2],
    );

    if (latest > current) {
      _atualizado = false;
    } else {
      _atualizado = true;
    }
  }

  void loadData() async {
    usuarioController.text = await SecureStorage().ler('usuario');
    senhaController.text = await SecureStorage().ler('senha');
  }

  void clear() {
    senhaController.clear();
  }

  void login() async {
    final config = Provider.of<AppConfig>(context, listen: false);
    final navigator = Navigator.of(context);

    try {
      await _getVersion();
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: Expanded(
                  child: Wrap(
                    children: [
                      Text(
                        ex.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                tipo: Icones.info,
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

      return;
    }

    if (!_atualizado) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Wrap(
                  children: [
                    Text(
                      'Atenção, existe uma nova versão disponível. Por favor, atualize-o antes de continuar.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ],
                ),
                tipo: Icones.info,
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Download (v${_requiredVersion[0]}.${_requiredVersion[1]}.${_requiredVersion[2]})',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );

      return;
    }

    setState(() => isWaiting = true);

    var user = User();
    user.user = usuarioController.text;
    user.password = senhaController.text;
    user.idLiberacao = idLiberacaoController.text;

    try {
      var response = await UserDAO().auth(user);

      if (response) {
        await Configuracoes().verificaFechamentoPedAntSeparacao();

        if (config.salvarDados) {
          SecureStorage().salvar('usuario', usuarioController.text);
          SecureStorage().salvar('senha', senhaController.text);
        } else {
          SecureStorage().apagar('usuario');
          SecureStorage().apagar('senha');
        }

        idLiberacaoController.clear();

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

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          Center(
                            child: Text(message),
                          ),
                        ],
                      ),
                    ),
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
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    _version,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
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
