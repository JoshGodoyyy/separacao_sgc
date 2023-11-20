import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/pedidos.dart';
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
  @override
  Widget build(BuildContext context) {
    var widgets = Provider.of<AppConfig>(context);

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
                        count: Pedidos.pedidosSeparar.length,
                        icon: Icons.account_tree_rounded,
                        page: const MainPage(
                          title: 'Separar',
                          status: 'Separar',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.separando,
                      child: HomeButton(
                        title: 'Separando',
                        count: Pedidos.pedidosSeparando.length,
                        icon: Icons.alt_route_outlined,
                        page: const MainPage(
                          title: 'Separando',
                          status: 'Separando',
                        ),
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
                        count: Pedidos.pedidosEmbalagem.length,
                        icon: Icons.bento,
                        page: const MainPage(
                          title: 'Embalagem',
                          status: 'Embalagem',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.conferencia,
                      child: HomeButton(
                        title: 'Conferência',
                        count: Pedidos.pedidosConferencia.length,
                        icon: Icons.app_registration_outlined,
                        page: const MainPage(
                          title: 'Conferência',
                          status: 'Conferencia',
                        ),
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
                        count: Pedidos.pedidosFaturar.length,
                        icon: Icons.request_page_outlined,
                        page: const MainPage(
                          title: 'Faturar',
                          status: 'Faturar',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.logistica,
                      child: HomeButton(
                        title: 'Logística',
                        count: Pedidos.pedidosLogistica.length,
                        icon: Icons.rv_hookup_outlined,
                        page: const MainPage(
                          title: 'Logística',
                          status: 'Logistica',
                        ),
                      ),
                    ),
                  ],
                ),
                const SettingsButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
