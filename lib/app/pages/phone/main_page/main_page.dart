import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/config/user.dart';
import '../../../data/blocs/pedido/pedidos_bloc.dart';
import '../../../data/blocs/pedido/pedido_event.dart';
import '../../../data/blocs/pedido/pedidos_state.dart';
import '../../../models/pedido_model.dart';
import '../../../ui/styles/colors_app.dart';
import '../../../ui/widgets/error_alert.dart';
import '../order/order_page.dart';
import '../../../ui/widgets/list_header.dart';
import 'widgets/list_item.dart';

class MainPage extends StatefulWidget {
  final String title;
  final int status;
  final IconData icon;

  const MainPage({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final searchController = TextEditingController();
  late final PedidosBloc _pedidosBloc;
  List<PedidoModel> pedidos = [];
  late Timer timer;
  String search = '';

  @override
  void initState() {
    super.initState();
    _pedidosBloc = PedidosBloc();
    fetchData();

    const Duration duracao = Duration(seconds: 30);

    timer = Timer.periodic(duracao, (timer) {
      fetchData();
    });
  }

  fetchData() {
    if (search == '') {
      _pedidosBloc.inputPedido.add(
        GetPedidosSituacao(idSituacao: widget.status),
      );
    } else {
      _pedidosBloc.inputPedido.add(
        SearchPedido(
          idSituacao: widget.status,
          idPedido: int.parse(search),
        ),
      );
    }
  }

  String retrocederPedido() {
    var config = Provider.of<AppConfig>(context, listen: false);

    String result = '';

    switch (widget.title) {
      case 'Embalagem':
        result = 'Iniciar Separação';
        break;
      case 'Conferência':
        if (config.embalagem) {
          result = 'Liberar para Embalagem';
        } else {
          result = 'Iniciar Separação';
        }
        break;
      case 'Faturar':
        if (config.conferencia) {
          result = 'Liberar para Conferência';
        } else {
          if (config.embalagem) {
            result = 'Liberar para Embalagem';
          } else {
            result = 'Iniciar Separação';
          }
        }
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: TextField(
                      controller: searchController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                      ],
                      onChanged: (value) {
                        if (searchController.text == '') {
                          search = '';
                          fetchData();
                        } else {
                          search = searchController.text;
                          fetchData();
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Pesquisar',
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 5,
                  color: ColorsApp.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (searchController.text == '') {
                        search = '';
                        fetchData();
                      } else {
                        search = searchController.text;
                        fetchData();
                      }
                    },
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _pedidosBloc.inputPedido.add(
                  GetPedidosSituacao(idSituacao: widget.status),
                );
              },
              child: widget.status == 3 ? pedidosFiltrados() : todosPedidos(),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<PedidosState> pedidosFiltrados() {
    return StreamBuilder<PedidosState>(
      stream: _pedidosBloc.outputPedido,
      builder: (context, snapshot) {
        if (snapshot.data is PedidosLoadingState) {
          return ListView(
            children: [
              ListHeader(
                label: 'Meus Pedidos',
                count: '${snapshot.data!.pedidos.where(
                      (pedido) =>
                          pedido.separadorIniciar.toString().toLowerCase() ==
                          UserConstants().userName!.toLowerCase(),
                    ).toList().length}',
              ),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() ==
                    UserConstants().userName!.toLowerCase())
                  ListItem(
                    icon: widget.icon,
                    pedido: pedido,
                    onClick: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (builder) => OrderPage(
                                pedido: pedido,
                              ),
                            ),
                          )
                          .then(
                            (value) => _pedidosBloc.inputPedido.add(
                              GetPedidosSituacao(idSituacao: widget.status),
                            ),
                          );
                    },
                  ),
              ListHeader(
                label: 'Pedidos Gerais',
                count: '${snapshot.data!.pedidos.where(
                      (pedido) =>
                          pedido.separadorIniciar.toString().toLowerCase() !=
                          UserConstants().userName!.toLowerCase(),
                    ).toList().length}',
              ),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() !=
                    UserConstants().userName!.toLowerCase())
                  ListItem(
                    icon: widget.icon,
                    pedido: pedido,
                    onClick: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (builder) => OrderPage(
                                pedido: pedido,
                              ),
                            ),
                          )
                          .then(
                            (value) => _pedidosBloc.inputPedido.add(
                              GetPedidosSituacao(idSituacao: widget.status),
                            ),
                          );
                    },
                  ),
            ],
          );
        } else if (snapshot.data is PedidosLoadedState) {
          pedidos = snapshot.data!.pedidos;
          return ListView(
            children: [
              ListHeader(
                label: 'Meus Pedidos',
                count: '${snapshot.data!.pedidos.where(
                      (pedido) =>
                          pedido.separadorIniciar.toString().toLowerCase() ==
                          UserConstants().userName!.toLowerCase(),
                    ).toList().length}',
              ),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() ==
                    UserConstants().userName!.toLowerCase())
                  ListItem(
                    icon: widget.icon,
                    pedido: pedido,
                    onClick: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (builder) => OrderPage(
                                pedido: pedido,
                              ),
                            ),
                          )
                          .then(
                            (value) => _pedidosBloc.inputPedido.add(
                              GetPedidosSituacao(idSituacao: widget.status),
                            ),
                          );
                    },
                  ),
              ListHeader(
                label: 'Pedidos Gerais',
                count: '${snapshot.data!.pedidos.where(
                      (pedido) =>
                          pedido.separadorIniciar.toString().toLowerCase() !=
                          UserConstants().userName!.toLowerCase(),
                    ).toList().length}',
              ),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() !=
                    UserConstants().userName!.toLowerCase())
                  ListItem(
                    icon: widget.icon,
                    pedido: pedido,
                    onClick: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (builder) => OrderPage(
                                pedido: pedido,
                              ),
                            ),
                          )
                          .then(
                            (value) => _pedidosBloc.inputPedido.add(
                              GetPedidosSituacao(idSituacao: widget.status),
                            ),
                          );
                    },
                  ),
            ],
          );
        } else {
          return ErrorAlert(
            message: snapshot.error.toString(),
          );
        }
      },
    );
  }

  StreamBuilder<PedidosState> todosPedidos() {
    return StreamBuilder<PedidosState>(
      stream: _pedidosBloc.outputPedido,
      builder: (context, snapshot) {
        if (snapshot.data is PedidosLoadingState) {
          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              PedidoModel pedido = pedidos[index];
              return ListItem(
                icon: widget.icon,
                pedido: pedido,
                onClick: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (builder) => OrderPage(
                            pedido: pedido,
                          ),
                        ),
                      )
                      .then(
                        (value) => _pedidosBloc.inputPedido.add(
                          GetPedidosSituacao(idSituacao: widget.status),
                        ),
                      );
                },
              );
            },
          );
        } else if (snapshot.data is PedidosLoadedState) {
          pedidos = snapshot.data!.pedidos;
          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              PedidoModel pedido = pedidos[index];
              return ListItem(
                icon: widget.icon,
                pedido: pedido,
                onClick: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (builder) => OrderPage(
                            pedido: pedido,
                          ),
                        ),
                      )
                      .then(
                        (value) => _pedidosBloc.inputPedido.add(
                          GetPedidosSituacao(idSituacao: widget.status),
                        ),
                      );
                },
              );
            },
          );
        } else {
          return ErrorAlert(
            message: snapshot.error.toString(),
          );
        }
      },
    );
  }
}
