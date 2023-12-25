import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/blocs/pedido/pedido_bloc.dart';
import '../../data/blocs/pedido/pedido_event.dart';
import '../../data/blocs/pedido/pedido_state.dart';
import '../../models/pedido_model.dart';
import '../../ui/styles/colors_app.dart';
import '../../ui/widgets/error_alert.dart';
import '../order/order_page.dart';
import 'widgets/list_header.dart';
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
  late final PedidoBloc _pedidoBloc;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    _pedidoBloc = PedidoBloc();
    _pedidoBloc.inputPedido.add(GetPedidosSituacao(idSituacao: widget.status));
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
                      onChanged: (value) {},
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
                      setState(() {});
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
                _pedidoBloc.inputPedido.add(
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

  StreamBuilder<PedidoState> pedidosFiltrados() {
    return StreamBuilder<PedidoState>(
      stream: _pedidoBloc.outputPedido,
      builder: (context, snapshot) {
        if (snapshot.data is PedidoLoadingState) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        } else if (snapshot.data is PedidoLoadedState) {
          List pedidos = snapshot.data!.pedidos;
          return ListView(
            children: [
              const ListHeader(label: 'Meus Pedidos'),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() == 'josh')
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
                            (value) => _pedidoBloc.inputPedido.add(
                              GetPedidosSituacao(idSituacao: widget.status),
                            ),
                          );
                    },
                  ),
              const ListHeader(label: 'Pedidos Gerais'),
              for (var pedido in pedidos)
                if (pedido.separadorIniciar.toString().toLowerCase() != 'josh')
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
                            (value) => _pedidoBloc.inputPedido.add(
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

  StreamBuilder<PedidoState> todosPedidos() {
    return StreamBuilder<PedidoState>(
      stream: _pedidoBloc.outputPedido,
      builder: (context, snapshot) {
        if (snapshot.data is PedidoLoadingState) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        } else if (snapshot.data is PedidoLoadedState) {
          List pedidos = snapshot.data!.pedidos;
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
                        (value) => _pedidoBloc.inputPedido.add(
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

  @override
  void dispose() {
    _pedidoBloc.inputPedido.close();
    super.dispose();
  }
}
