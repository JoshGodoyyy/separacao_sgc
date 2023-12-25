import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sgc/app/pages/order/pages/packaging_page/packaging.dart';

import '../../ui/styles/colors_app.dart';
import 'pages/general_info_page/general_info.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';
import '../../models/pedido_model.dart';

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
  final codigoVendedorController = TextEditingController();

  void clear() {
    codigoVendedorController.clear();
  }

  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  late Timer timer;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSecond,
      (timer) {
        setState(
          () {
            _seconds++;
            if (_seconds == 60) {
              _seconds = 0;
              _minutes++;
              if (_minutes == 60) {
                _minutes = 0;
                _hours++;
              }
            }
          },
        );
      },
    );
  }

  String durationValue() {
    String result;
    String hours = _hours.toString().padLeft(2, '0');
    String minutes = _minutes.toString().padLeft(2, '0');
    String seconds = _seconds.toString().padLeft(2, '0');

    _seconds == 0
        ? result = 'Não Iniciado'
        : result = '$hours:$minutes:$seconds';

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.pedido.id} - ${widget.pedido.nomeCliente}',
              ),
              Text(
                'Duração: ${durationValue()}',
                style: const TextStyle(
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
                text: 'Dados Gerais',
              ),
              Tab(
                text: 'Produtos',
              ),
              Tab(
                text: 'Separação',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GeneralInfo(
              idPedido: int.parse(
                widget.pedido.id.toString(),
              ),
            ),
            Products(pedido: widget.pedido),
            Separation(
              pedido: widget.pedido,
              context: context,
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          iconTheme: const IconThemeData(color: Colors.white),
          overlayOpacity: 0.6,
          backgroundColor: ColorsApp.primaryColor,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.shopping_cart_outlined),
              label: 'Finalizar Separação',
            ),
            SpeedDialChild(
              child: const Icon(Icons.checklist_rtl_rounded),
              label: 'Liberar para Conferência',
            ),
            SpeedDialChild(
              child: const Icon(Icons.archive),
              label: 'Liberar para Embalagem',
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_walk_outlined),
              label: 'Iniciar Separação',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'SGC',
                      ),
                      content: const Text(
                        'Deseja iniciar separação?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            startTimer();
                          },
                          child: const Text(
                            'Sim',
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Não',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.inbox),
              label: 'Embalagens',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => Packaging(pedido: widget.pedido),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
