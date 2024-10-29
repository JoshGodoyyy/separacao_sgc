import 'package:flutter/material.dart';
import 'package:sgc/app/models/client_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

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
              numeroEntrega: widget.cliente.numero ?? '',
              cepEntrega: widget.cliente.cep ?? '',
              idRoteiro: int.parse(
                widget.roteiroEntrega.id.toString(),
              ),
              idCliente: int.parse(
                widget.cliente.idCliente.toString(),
              ),
            ),
            PedidosCarregados(
              numeroEntrega: widget.cliente.numero ?? '',
              cepEntrega: widget.cliente.cep ?? '',
              idRoteiro: int.parse(
                widget.roteiroEntrega.id.toString(),
              ),
              idCliente: int.parse(
                widget.cliente.idCliente.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
