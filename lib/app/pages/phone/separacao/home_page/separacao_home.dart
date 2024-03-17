import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_config.dart';
import '../../../../data/repositories/pedido.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/utils/notificacao.dart';
import '../main_page/main_page.dart';
import 'widgets/home_button.dart';

class SeparacaoHome extends StatefulWidget {
  const SeparacaoHome({super.key});

  @override
  State<SeparacaoHome> createState() => _HomeState();
}

class _HomeState extends State<SeparacaoHome> {
  double pesoSeparar = 0;
  double pesoSeparando = 0;
  double pesoEmbalagem = 0;
  double pesoConferencia = 0;
  double pesoFaturar = 0;
  double pesoLogistica = 0;

  bool carregando = false;
  late Timer timer;

  loadData() async {
    var orders = Provider.of<Pedido>(context, listen: false);
    setState(() => carregando = true);
    await orders.fetchData(2);
    await orders.fetchData(3);
    await orders.fetchData(5);
    await orders.fetchData(10);
    await orders.fetchData(14);
    await orders.fetchData(15);
    setState(() => carregando = false);
    alertarBalcao(
      orders.pedidosSeparar.any(
        (pedido) => pedido.tipoEntrega == 'BAL',
      ),
      orders.pedidosSeparar
          .where((pedido) => pedido.tipoEntrega == 'BAL')
          .toList(),
    );

    alertarRetirar(
      orders.pedidosSeparar.any(
        (pedido) => pedido.tipoEntrega == 'RET',
      ),
      orders.pedidosSeparar
          .where((pedido) => pedido.tipoEntrega == 'RET')
          .toList(),
    );
  }

  void alertarBalcao(bool value, List pedidos) async {
    var config = Provider.of<AppConfig>(context, listen: false);

    String ids = '';
    String nomes = '';

    for (var pedido in pedidos) {
      ids += '${pedido.id}\n';
      nomes += '${pedido.nomeCliente}\n';
    }

    if (config.balcao && value) {
      Provider.of<NotificacaoService>(context, listen: false).showNotificacao(
        Notificacao(
          id: 1,
          title: 'SGC Separar',
          body: '$ids $nomes Balcão',
          payload: null,
        ),
      );
    }
  }

  void alertarRetirar(bool value, List pedidos) async {
    var config = Provider.of<AppConfig>(context, listen: false);
    String ids = '';
    String nomes = '';

    for (var pedido in pedidos) {
      ids += '${pedido.id}\n';
      nomes += '${pedido.nomeCliente}\n';
    }

    if (config.retirar && value) {
      Provider.of<NotificacaoService>(context, listen: false).showNotificacao(
        Notificacao(
          id: 1,
          title: 'SGC Separar',
          body: 'Pedido(s): $ids $nomes Retirar',
          payload: null,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      const Duration duracao = Duration(seconds: 30);

      timer = Timer.periodic(duracao, (timer) {
        loadData();
      });

      setState(() => carregando = true);
      _calcularPeso();
      setState(() => carregando = false);
    }
  }

  _calcularPeso() {
    pesoSeparar = 0;
    pesoSeparando = 0;
    pesoEmbalagem = 0;
    pesoConferencia = 0;
    pesoFaturar = 0;
    pesoLogistica = 0;

    var orders = Provider.of<Pedido>(context, listen: false);

    for (PedidoModel pedido in orders.pedidosSeparar) {
      pesoSeparar += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosSeparando) {
      pesoSeparando += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosEmbalagem) {
      pesoEmbalagem += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosConferencia) {
      pesoConferencia += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosFaturar) {
      pesoFaturar += double.parse(pedido.pesoTotal.toString());
    }

    for (PedidoModel pedido in orders.pedidosLogistica) {
      pesoLogistica += double.parse(pedido.pesoTotal.toString());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var widgets = Provider.of<AppConfig>(context);
    var orders = Provider.of<Pedido>(context);

    return RefreshIndicator(
      onRefresh: () async => loadData(),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Visibility(
                visible: widgets.separar,
                child: HomeButton(
                  title: 'Separar',
                  count: orders.pedidosSeparar.length,
                  weight: pesoSeparar,
                  icon: Icons.account_tree_rounded,
                  page: const MainPage(
                    icon: Icons.account_tree_rounded,
                    title: 'Separar',
                    status: 2,
                  ),
                  begin: Colors.red,
                  end: Colors.red[200]!,
                  refresh: loadData,
                ),
              ),
              Visibility(
                visible: widgets.separando,
                child: HomeButton(
                  title: 'Separando',
                  count: orders.pedidosSeparando.length,
                  weight: pesoSeparando,
                  icon: Icons.alt_route_outlined,
                  page: const MainPage(
                    icon: Icons.alt_route_outlined,
                    title: 'Separando',
                    status: 3,
                  ),
                  begin: Colors.orange,
                  end: const Color(0xFFFFC267),
                  refresh: loadData,
                ),
              ),
              Visibility(
                visible: widgets.embalagem,
                child: HomeButton(
                  title: 'Embalagem',
                  count: orders.pedidosEmbalagem.length,
                  weight: pesoEmbalagem,
                  icon: Icons.bento,
                  page: const MainPage(
                    icon: Icons.bento,
                    title: 'Embalagem',
                    status: 14,
                  ),
                  begin: const Color(0xff6482b4),
                  end: const Color(0xff64b9e6),
                  refresh: loadData,
                ),
              ),
              Visibility(
                visible: widgets.conferencia,
                child: HomeButton(
                  title: 'Conferência',
                  count: orders.pedidosConferencia.length,
                  weight: pesoConferencia,
                  icon: Icons.app_registration_outlined,
                  page: const MainPage(
                    icon: Icons.app_registration_outlined,
                    title: 'Conferência',
                    status: 15,
                  ),
                  begin: const Color(0xffa300d3),
                  end: const Color(0xFFE2A6DE),
                  refresh: loadData,
                ),
              ),
              Visibility(
                visible: widgets.faturar,
                child: HomeButton(
                  title: 'Faturar',
                  count: orders.pedidosFaturar.length,
                  weight: pesoFaturar,
                  icon: Icons.request_page_outlined,
                  page: const MainPage(
                    icon: Icons.request_page_outlined,
                    title: 'Faturar',
                    status: 5,
                  ),
                  begin: const Color(0xff348000),
                  end: const Color(0xFF97DB6A),
                  refresh: loadData,
                ),
              ),
              Visibility(
                visible: widgets.logistica,
                child: HomeButton(
                  title: 'Logística',
                  count: orders.pedidosLogistica.length,
                  weight: pesoLogistica,
                  icon: Icons.rv_hookup_outlined,
                  page: const MainPage(
                    icon: Icons.rv_hookup_outlined,
                    title: 'Logística',
                    status: 10,
                  ),
                  begin: const Color(0xFFFFC400),
                  end: const Color(0xFFF7E180),
                  refresh: loadData,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Visibility(
              visible: carregando,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  child: LinearProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
