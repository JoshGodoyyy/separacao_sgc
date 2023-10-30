import 'package:flutter/material.dart';

import '../../data/pedidos.dart';
import '../../models/pedido_model.dart';
import 'widgets/list_item.dart';

class MainPage extends StatefulWidget {
  final String title;
  final String status;

  const MainPage({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (Pedido pedido in Pedidos.pedidosSeparar)
            if (pedido.statusPedido == widget.status) ListItem(pedido: pedido),
        ],
      ),
    );
  }
}
