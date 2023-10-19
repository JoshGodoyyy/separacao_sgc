import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/widgets/item.dart';

import '../../ui/styles/colors_app.dart';
import '/app/models/pedido_model.dart';

class Order extends StatefulWidget {
  final Pedido pedido;
  const Order({
    super.key,
    required this.pedido,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.elementColor,
        title: Text(
          '${widget.pedido.idPedido}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Item(label: 'Data de criação:'),
          const Item(label: 'Fantasia:'),
          const Item(label: 'Id orçamento:'),
          const Item(label: 'Pedido cliente:'),
          const Item(label: 'Observações:'),
          const Item(label: 'Data de entrega:'),
          const Item(label: 'Tipo de entrega:'),
          const Item(label: 'Peso:'),
          const Item(label: 'Tratamento:'),
          const Item(label: 'Cidade:'),
          const Item(label: 'Setor de entrega:'),
          const Item(label: 'Vendedor:'),
          const Item(label: 'Data de liberação:'),
          const Item(label: 'Financeiro:'),
          const Item(label: 'Status:'),
        ],
      ),
    );
  }
}
