import 'package:flutter/material.dart';

import '../../data/pedidos.dart';
import '../../models/pedido_model.dart';
import '/app/ui/styles/colors_app.dart';
import 'widgets/list_item.dart';

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (Pedido pedido in Pedidos.pedidosSeparar)
            ListItem(pedido: pedido),
        ],
      ),
    );
  }
}
