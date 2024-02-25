import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/pages/tablet/configuracoes/configuracoes.dart';
import 'package:sgc/app/pages/tablet/home_page/widgets/todos_pedidos.dart';
import '../../../config/capitalize_text.dart';
import '../../../config/menu_state.dart';
import '../../../config/user.dart';
import '../login_page/login_page.dart';
import 'widgets/c_drawer_button.dart';
import 'widgets/pedido_info.dart';

class THomePage extends StatefulWidget {
  const THomePage({super.key});

  @override
  State<THomePage> createState() => _THomePageState();
}

class _THomePageState extends State<THomePage> {
  String user = CapitalizeText.capitalizeFirstLetter(
    UserConstants().userName!.split(' ')[0].toLowerCase(),
  );

  int _indexTela = 0;

  double _largura = 60;

  final List<Widget> _telas = const [
    TodosPedidos(),
    TConfiguracoes(),
  ];

  @override
  Widget build(BuildContext context) {
    final menuEstado = Provider.of<MenuState>(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: _largura,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CDrawerButton(
                              icone: Icons.menu,
                              titulo: 'Menu',
                              onTap: () => setState(
                                () => _largura = _largura == 60 ? 250 : 60,
                              ),
                              selecionado: false,
                            ),
                            const Spacer(),
                            // CDrawerButton(
                            //   icone: Icons.assignment_add,
                            //   titulo: 'Orçamentos',
                            //   onTap: () {},
                            // ),
                            // CDrawerButton(
                            //   icone: Icons.assignment_add,
                            //   titulo: 'Novo Orçamento',
                            //   onTap: () {},
                            // ),
                            CDrawerButton(
                              icone: Icons.add_shopping_cart_rounded,
                              titulo: 'Separação',
                              onTap: () => setState(() {
                                _indexTela = 0;
                                menuEstado.setEstado(false);
                              }),
                              selecionado: _indexTela == 0 ? true : false,
                            ),
                            // CDrawerButton(
                            //   icone: Icons.route,
                            //   titulo: 'Rotas de Entrega',
                            //   onTap: () {},
                            // ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(),
                            ),
                            CDrawerButton(
                              icone: Icons.settings,
                              titulo: 'Configurações',
                              onTap: () => setState(() {
                                _indexTela = 1;
                                menuEstado.setEstado(false);
                              }),
                              selecionado: _indexTela == 1 ? true : false,
                            ),
                            const Spacer(),
                            CDrawerButton(
                              icone: Icons.exit_to_app_rounded,
                              titulo: 'Sair',
                              onTap: () => sair(context),
                              selecionado: false,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'SGC Mobile',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Olá, $user',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Visibility(
                                    visible: _indexTela == 0 ? true : false,
                                    child: Expanded(
                                      child: Material(
                                        elevation: 5,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Pesquisar',
                                            suffixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              _telas[_indexTela],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const PedidoInfo()
        ],
      ),
    );
  }

  Future<dynamic> sair(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'SGC',
          ),
          content: const Text(
            'Deseja mesmo sair?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (builder) => const TLoginPage(),
                  ),
                );
              },
              child: const Text(
                'Sim',
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Não',
              ),
            ),
          ],
        );
      },
    );
  }
}
