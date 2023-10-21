import 'package:flutter/material.dart';
import 'package:sgc/app/pages/main_page/widgets/pages/accessories.dart';
import 'package:sgc/app/pages/main_page/widgets/pages/all_items.dart';
import 'package:sgc/app/pages/main_page/widgets/pages/profiles.dart';

import '/app/pages/main_page/widgets/main_header.dart';
import '/app/ui/styles/colors_app.dart';
import '/app/pages/main_page/widgets/nav_button.dart';

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    super.key,
    required this.title,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      'Acessórios',
      'Perfis',
      'Todos',
    ];

    final List<Widget> screens = [
      Accessories(),
      Profiles(),
      AllItems(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsApp.elementColor,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          MainHeader(
            title: titles[currentPage],
          ),
          Expanded(child: screens[currentPage])
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: ColorsApp.elementColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 1,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavButton(
                icon: Icons.all_inbox,
                label: 'Acessórios',
                onTap: () => setState(() => currentPage = 0),
              ),
              NavButton(
                icon: Icons.check_box_outline_blank_rounded,
                label: 'Perfis',
                onTap: () => setState(() => currentPage = 1),
              ),
              NavButton(
                icon: Icons.auto_awesome_motion,
                label: 'Todos',
                onTap: () => setState(() => currentPage = 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
