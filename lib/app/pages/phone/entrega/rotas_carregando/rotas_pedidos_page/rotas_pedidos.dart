import 'package:flutter/material.dart';
import 'package:sgc/app/models/client_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../ui/styles/colors_app.dart';
import 'screens/pedidos_nao_carregados.dart';
import 'screens/pedidos_carregados.dart';

class RotasPedidos extends StatefulWidget {
  final RoteiroEntregaModel roteiroEntrega;
  final ClienteModel cliente;
  const RotasPedidos({
    super.key,
    required this.roteiroEntrega,
    required this.cliente,
  });

  @override
  State<RotasPedidos> createState() => _RotasPedidosState();
}

class _RotasPedidosState extends State<RotasPedidos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.cliente.fantasia ?? ''),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorsApp.primaryColor,
            tabs: [
              Tab(
                text: 'Não Carregados',
              ),
              Tab(
                text: 'Carregados',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PedidosNaoCarregados(
              idRoteiro: int.parse(
                widget.roteiroEntrega.id.toString(),
              ),
              idCliente: int.parse(
                widget.cliente.id.toString(),
              ),
            ),
            PedidosCarregados(
              idRoteiro: int.parse(
                widget.roteiroEntrega.id.toString(),
              ),
              idCliente: int.parse(
                widget.cliente.id.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
