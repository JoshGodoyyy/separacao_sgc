import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/repositories/pedidos.dart';
import 'package:sgc/app/pages/home_page/widgets/home_header.dart';
import 'package:sgc/app/pages/main_page/main_page.dart';

import '/app/pages/home_page/widgets/home_button.dart';
import 'widgets/settings_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadData() async {
    var orders = Provider.of<Pedidos>(context, listen: false);
    await orders.fetchData(2);
    await orders.fetchData(3);
    await orders.fetchData(5);
    await orders.fetchData(10);
    await orders.fetchData(14);
    await orders.fetchData(15);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var widgets = Provider.of<AppConfig>(context);
    var orders = Provider.of<Pedidos>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'SGC Mobile',
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
    );
  }
}
