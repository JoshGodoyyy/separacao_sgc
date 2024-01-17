import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/models/pedido_model.dart';
import 'package:sgc/app/pages/home_page/widgets/home_header.dart';
import 'package:sgc/app/pages/main_page/main_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../login_page/login_page.dart';
import '/app/pages/home_page/widgets/home_button.dart';
import 'widgets/settings_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  double pesoSeparar = 0;
  double pesoSeparando = 0;
  double pesoEmbalagem = 0;
  double pesoConferencia = 0;
  double pesoFaturar = 0;
  double pesoLogistica = 0;

  loadData() async {
    var orders = Provider.of<Pedido>(context, listen: false);
    await orders.fetchData(2);
    await orders.fetchData(3);
    await orders.fetchData(5);
    await orders.fetchData(10);
    await orders.fetchData(14);
    await orders.fetchData(15);

    pesoSeparar = 0;
    pesoSeparando = 0;
    pesoEmbalagem = 0;
    pesoConferencia = 0;
    pesoFaturar = 0;
    pesoLogistica = 0;

    for (PedidoModel pedido in orders.pedidosSeparar) {
      pesoSeparar += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosSeparando) {
      pesoSeparando += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosEmbalagem) {
      pesoEmbalagem += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosConferencia) {
      pesoConferencia += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosFaturar) {
      pesoFaturar += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosLogistica) {
      pesoLogistica += double.parse(pedido.pesoTotal.toString());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var widgets = Provider.of<AppConfig>(context);
    var orders = Provider.of<Pedido>(context);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                const SizedBox(height: 64),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Orçamentos'),
                ),
                ListTile(
                  onTap: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                          message: 'Feature em desenvolvimento'),
                    );
                  },
                  leading: const Icon(Icons.assignment_add),
                  title: const Text('Orçamentos'),
                ),
                ListTile(
                  onTap: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                          message: 'Feature em desenvolvimento'),
                    );
                  },
                  leading: const Icon(Icons.assignment_add),
                  title: const Text('Novo Orçamento'),
                ),
                ListTile(
                  onTap: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                          message: 'Feature em desenvolvimento'),
                    );
                  },
                  leading: const Icon(Icons.assignment_add),
                  title: const Text('Orçamento de Pedidos'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Separação'),
                ),
                ListTile(
                  onTap: () {
                    _advancedDrawerController.hideDrawer();
                  },
                  leading: const Icon(Icons.add_shopping_cart_rounded),
                  title: const Text('Separação'),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    showDialog(
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
                                    builder: (builder) => const LoginPage(),
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
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Sair'),
                ),
              ],
            ),
          ),
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
              child: RefreshIndicator(
                onRefresh: () async {
                  loadData();
                },
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Visibility(
                          visible: widgets.separar,
                          child: HomeButton(
                            title: 'Separar',
                            count: orders.pedidosSeparar.length,
                            weight: pesoSeparar,
                            icon: Icons.account_tree_rounded,
                            page: const MainPage(
                              icon: Icons.account_tree_rounded,
                              title: 'Separar',
                              status: 2,
                            ),
                            begin: Colors.red,
                            end: Colors.red[200]!,
                          ),
                        ),
                        Visibility(
                          visible: widgets.separando,
                          child: HomeButton(
                            title: 'Separando',
                            count: orders.pedidosSeparando.length,
                            weight: pesoSeparando,
                            icon: Icons.alt_route_outlined,
                            page: const MainPage(
                              icon: Icons.alt_route_outlined,
                              title: 'Separando',
                              status: 3,
                            ),
                            begin: Colors.orange,
                            end: const Color(0xFFFFC267),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Visibility(
                          visible: widgets.embalagem,
                          child: HomeButton(
                            title: 'Embalagem',
                            count: orders.pedidosEmbalagem.length,
                            weight: pesoEmbalagem,
                            icon: Icons.bento,
                            page: const MainPage(
                              icon: Icons.bento,
                              title: 'Embalagem',
                              status: 14,
                            ),
                            begin: const Color(0xff6482b4),
                            end: const Color(0xff64b9e6),
                          ),
                        ),
                        Visibility(
                          visible: widgets.conferencia,
                          child: HomeButton(
                            title: 'Conferência',
                            count: orders.pedidosConferencia.length,
                            weight: pesoConferencia,
                            icon: Icons.app_registration_outlined,
                            page: const MainPage(
                              icon: Icons.app_registration_outlined,
                              title: 'Conferência',
                              status: 15,
                            ),
                            begin: const Color(0xffa300d3),
                            end: const Color(0xFFE2A6DE),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Visibility(
                          visible: widgets.faturar,
                          child: HomeButton(
                            title: 'Faturar',
                            count: orders.pedidosFaturar.length,
                            weight: pesoFaturar,
                            icon: Icons.request_page_outlined,
                            page: const MainPage(
                              icon: Icons.request_page_outlined,
                              title: 'Faturar',
                              status: 5,
                            ),
                            begin: const Color(0xff348000),
                            end: const Color(0xFF97DB6A),
                          ),
                        ),
                        Visibility(
                          visible: widgets.logistica,
                          child: HomeButton(
                            title: 'Logística',
                            count: orders.pedidosLogistica.length,
                            weight: pesoLogistica,
                            icon: Icons.rv_hookup_outlined,
                            page: const MainPage(
                              icon: Icons.rv_hookup_outlined,
                              title: 'Logística',
                              status: 10,
                            ),
                            begin: const Color(0xFFFFC400),
                            end: const Color(0xFFF7E180),
                          ),
                        ),
                      ],
                    ),
                    const SettingsButton()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
