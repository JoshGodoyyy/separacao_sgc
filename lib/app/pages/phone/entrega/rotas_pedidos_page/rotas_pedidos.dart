import 'package:flutter/material.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_pedidos_page/widgets/pedido_list_item.dart';

import '../../../../ui/styles/colors_app.dart';

class RotasPedidos extends StatefulWidget {
  final String nomeCliente;
  const RotasPedidos({
    super.key,
    required this.nomeCliente,
  });

  @override
  State<RotasPedidos> createState() => _RotasPedidosState();
}

class _RotasPedidosState extends State<RotasPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.nomeCliente),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Material(
              elevation: 5,
              color: ColorsApp.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Não Carregados',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Material(
              elevation: 5,
              color: ColorsApp.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Carregados',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
          PedidoListItem(),
        ],
      ),
    );
  }
}
