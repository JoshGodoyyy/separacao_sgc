import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../ui/styles/colors_app.dart';
import 'pages/general_info.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';
import '/app/models/pedido_model.dart';

class OrderPage extends StatefulWidget {
  final Pedido pedido;
  const OrderPage({
    super.key,
    required this.pedido,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int currentPage = 0;

  final codigoVendedorController = TextEditingController();

  void clear() {
    codigoVendedorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.pedido.idPedido} - ${widget.pedido.cliente.fantasia}',
              ),
              const Text(
                'Duração: 1:00:59',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorsApp.primaryColor,
            tabs: [
              Tab(
                text: 'Produtos',
              ),
              Tab(
                text: 'Dados Gerais',
              ),
              Tab(
                text: 'Separação',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Products(pedido: widget.pedido),
            GeneralInfo(pedido: widget.pedido),
            Separation(pedido: widget.pedido),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          iconTheme: const IconThemeData(color: Colors.white),
          overlayOpacity: 0.6,
          backgroundColor: ColorsApp.primaryColor,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.directions_walk_outlined),
              label: 'Iniciar Separação',
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.archive),
              label: 'Liberar para Embalagem',
            ),
            SpeedDialChild(
              child: const Icon(Icons.checklist_rtl_rounded),
              label: 'Liberar para Conferência',
            ),
            SpeedDialChild(
              child: const Icon(Icons.shopping_cart_outlined),
              label: 'Finalizar Separação',
            ),
          ],
        ),
      ),
    );
  }
}
