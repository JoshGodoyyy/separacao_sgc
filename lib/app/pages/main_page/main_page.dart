import 'package:flutter/material.dart';
import 'package:sgc/app/data/pedidos.dart';
import 'package:sgc/app/models/pedido_model.dart';

import '/app/pages/main_page/widgets/main_header.dart';
import '/app/ui/styles/colors_app.dart';
import '/app/pages/main_page/widgets/nav_button.dart';
import '/app/pages/main_page/widgets/list_item.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsApp.elementColor,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const MainHeader(
            title: 'Acessórios',
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                for (Pedido pedido in Pedidos.pedidosSeparar)
                  ListItem(pedido: pedido),
              ],
            ),
          )
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
                onTap: () {},
              ),
              NavButton(
                icon: Icons.check_box_outline_blank_rounded,
                label: 'Perfis',
                onTap: () {},
              ),
              NavButton(
                icon: Icons.auto_awesome_motion,
                label: 'Todos',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
