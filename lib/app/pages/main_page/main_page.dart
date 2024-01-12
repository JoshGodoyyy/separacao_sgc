import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/blocs/pedido/pedidos_bloc.dart';
import '../../data/blocs/pedido/pedido_event.dart';
import '../../data/blocs/pedido/pedidos_state.dart';
import '../../models/pedido_model.dart';
import '../../ui/styles/colors_app.dart';
import '../../ui/widgets/error_alert.dart';
import '../order/order_page.dart';
import '../../ui/widgets/list_header.dart';
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
  late final List pedidos;

  @override
  void initState() {
    super.initState();
    _pedidosBloc = PedidosBloc();
    fetchData();
  }

  fetchData() {
    _pedidosBloc.inputPedido.add(
      GetPedidosSituacao(idSituacao: widget.status),
    );
  }

  searchData(String value) {
    _pedidosBloc.inputPedido.add(
      SearchPedido(
        idSituacao: widget.status,
        idPedido: int.parse(value),
      ),
    );
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
                          fetchData();
                        } else {
                          searchData(searchController.text);
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
                        fetchData();
                      } else {
                        searchData(searchController.text);
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
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        } else if (snapshot.data is PedidosLoadedState) {
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
                            (value) => _pedidosBloc.inputPedido.add(
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
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        } else if (snapshot.data is PedidosLoadedState) {
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

  @override
  void dispose() {
    _pedidosBloc.inputPedido.close();
    super.dispose();
  }
}
