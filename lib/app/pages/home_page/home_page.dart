import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/widgets.dart';
import 'package:sgc/app/data/user.dart';
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
  var data = User();
  var widgets = Widgets();
  @override
  Widget build(BuildContext context) {
    var separar = Provider.of<Widgets>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          data.companyName,
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
                      visible: separar.separar,
                      child: const HomeButton(
                        title: 'Separar',
                        icon: Icons.account_tree_rounded,
                        page: MainPage(
                          title: 'Separar',
                          status: 'Separar',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.separando,
                      child: const HomeButton(
                        title: 'Separando',
                        icon: Icons.alt_route_outlined,
                        page: MainPage(
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
                      child: const HomeButton(
                        title: 'Embalagem',
                        icon: Icons.bento,
                        page: MainPage(
                          title: 'Embalagem',
                          status: 'Embalagem',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.conferencia,
                      child: const HomeButton(
                        title: 'Conferência',
                        icon: Icons.app_registration_outlined,
                        page: MainPage(
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
                      child: const HomeButton(
                        title: 'Faturar',
                        icon: Icons.request_page_outlined,
                        page: MainPage(
                          title: 'Faturar',
                          status: 'Faturar',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widgets.logistica,
                      child: const HomeButton(
                        title: 'Logística',
                        icon: Icons.rv_hookup_outlined,
                        page: MainPage(
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
