import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/models/nivel_senha_model.dart';
import 'package:sgc/app/pages/phone/entrega/home_page/rotas_home.dart';
import 'package:sgc/app/pages/phone/estoque/consultar_estoque.dart';
import 'package:sgc/app/pages/phone/separacao/home_page/separacao_home.dart';
import 'package:sgc/app/pages/phone/settings_page/settings.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

import '../../../data/enums/icones.dart';
import '../../../data/repositories/nivel_senha.dart';
import '../../../ui/widgets/custom_dialog.dart';
import '../login_page/login_page.dart';
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  String _version = '';

  int _tela = 0;

  final _telas = const [
    ConsultarEstoque(),
    SeparacaoHome(),
    RotasHome(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    _getVersion();
    _tela = 1;
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(
        () => _version = '${packageInfo.version}+${packageInfo.buildNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff12111F),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      childDecoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_light.png',
                  fit: BoxFit.fill,
                  width: 255,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 8),
                  //   child: Text(
                  //     'Orçamento',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     _advancedDrawerController.hideDrawer();
                  //   },
                  //   leading: const Icon(
                  //     Icons.assignment_add,
                  //     color: Colors.white,
                  //   ),
                  //   title: const Text(
                  //     'Orçamentos',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     _advancedDrawerController.hideDrawer();
                  //     setState(() => _tela = 0);
                  //   },
                  //   leading: Icon(
                  //     Icons.search_rounded,
                  //     color:
                  //         _tela == 0 ? ColorsApp.secondaryColor : Colors.white,
                  //   ),
                  //   title: Text(
                  //     'Consultar Estoque',
                  //     style: TextStyle(
                  //       color: _tela == 0
                  //           ? ColorsApp.secondaryColor
                  //           : Colors.white,
                  //     ),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      _advancedDrawerController.hideDrawer();
                      setState(() => _tela = 1);
                    },
                    leading: Icon(
                      Icons.add_shopping_cart_rounded,
                      color:
                          _tela == 1 ? ColorsApp.secondaryColor : Colors.white,
                    ),
                    title: Text(
                      'Separação',
                      style: TextStyle(
                        color: _tela == 1
                            ? ColorsApp.secondaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _advancedDrawerController.hideDrawer();
                      setState(() => _tela = 2);
                    },
                    leading: Icon(
                      Icons.route_rounded,
                      color:
                          _tela == 2 ? ColorsApp.secondaryColor : Colors.white,
                    ),
                    title: Text(
                      'Roteiros de Entrega',
                      style: TextStyle(
                        color: _tela == 2
                            ? ColorsApp.secondaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      _advancedDrawerController.hideDrawer();
                      _verificarNivelSenha();
                    },
                    leading: Icon(
                      Icons.settings,
                      color:
                          _tela == 3 ? ColorsApp.secondaryColor : Colors.white,
                    ),
                    title: Text(
                      'Configurações',
                      style: TextStyle(
                        color: _tela == 3
                            ? ColorsApp.secondaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            titulo: 'Sistema SGC',
                            conteudo: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Deseja mesmo sair?'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: const Text('Sim'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Não'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            tipo: Icones.pergunta,
                          );
                        },
                      );
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Sair',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _version,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'SGC Mobile',
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, widget) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: _telas[_tela],
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  _verificarNivelSenha() async {
    final nivel = NivelSenhaModel(
      nivel: 'AppConfiguracoes',
      idUsuario: UserConstants().idUsuario,
    );

    await NivelSenha().verificarAcesso(nivel);
    bool response = await NivelSenha().verificarNivelSenha(nivel);

    if (!mounted) return;

    if (response) {
      setState(() => _tela = 3);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            titulo: 'Acesso restrito',
            conteudo: Text(
              'Nivel de senha requerido: ${nivel.nivel}',
              textAlign: TextAlign.center,
            ),
            tipo: Icones.erro,
          );
        },
      );
    }
  }
}
