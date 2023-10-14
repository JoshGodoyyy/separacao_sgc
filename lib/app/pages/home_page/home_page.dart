import 'package:flutter/material.dart';

import '/app/pages/home_page/widgets/home_button.dart';
import '/app/pages/login_page/login_page.dart';
import '/app/ui/styles/colors_app.dart';
import 'widgets/gradient_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (builder) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
        title: const Text(
          'Osmose',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: ColorsApp.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.elementColor,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorsApp.elementColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 3,
                )
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Olá, Sr. Rafinha',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Separar',
                      icon: Icons.account_tree_rounded,
                      onTap: () {},
                    ),
                    HomeButton(
                      title: 'Separando',
                      icon: Icons.alt_route_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Embalagem',
                      icon: Icons.bento,
                      onTap: () {},
                    ),
                    HomeButton(
                      title: 'Conferência',
                      icon: Icons.app_registration_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeButton(
                      title: 'Faturar',
                      icon: Icons.request_page_outlined,
                      onTap: () {},
                    ),
                    HomeButton(
                      title: 'Logística',
                      icon: Icons.rv_hookup_outlined,
                      onTap: () {},
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

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: ColorsApp.elementColor,
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GradientIcon(
                      icon: Icons.settings,
                      size: 54,
                      gradient: LinearGradient(
                        colors: [
                          ColorsApp.primaryColor,
                          ColorsApp.secondaryColor,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Configurações',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: ColorsApp.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
