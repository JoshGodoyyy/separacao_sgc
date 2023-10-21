import 'package:flutter/material.dart';

import '../list_item.dart';
import '/app/data/pedidos.dart';
import '/app/models/pedido_model.dart';

class Accessories extends StatefulWidget {
  const Accessories({super.key});

  @override
  State<Accessories> createState() => _AccessoriesState();
}

class _AccessoriesState extends State<Accessories> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        for (Pedido pedido in Pedidos.pedidosSeparar) ListItem(pedido: pedido),
      ],
    );
  }
}
