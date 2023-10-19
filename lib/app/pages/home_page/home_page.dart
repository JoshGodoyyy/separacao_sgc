import 'package:flutter/material.dart';
import 'package:sgc/app/data/user.dart';
import 'package:sgc/app/pages/home_page/widgets/home_header.dart';
import 'package:sgc/app/pages/main_page/main_page.dart';

import '/app/pages/home_page/widgets/home_button.dart';
import '/app/ui/styles/colors_app.dart';
import 'widgets/settings_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          data.companyName,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: ColorsApp.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.elementColor,
      ),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Separar',
                      icon: Icons.account_tree_rounded,
                      page: MainPage(
                        title: 'Separar',
                      ),
                    ),
                    HomeButton(
                      title: 'Separando',
                      icon: Icons.alt_route_outlined,
                      page: MainPage(
                        title: 'Separando',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Embalagem',
                      icon: Icons.bento,
                      page: MainPage(
                        title: 'Embalagem',
                      ),
                    ),
                    HomeButton(
                      title: 'Conferência',
                      icon: Icons.app_registration_outlined,
                      page: MainPage(
                        title: 'Conferência',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Faturar',
                      icon: Icons.request_page_outlined,
                      page: MainPage(
                        title: 'Faturar',
                      ),
                    ),
                    HomeButton(
                      title: 'Logística',
                      icon: Icons.rv_hookup_outlined,
                      page: MainPage(
                        title: 'Logística',
                      ),
                    ),
                  ],
                ),
                SettingsButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
