import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_event.dart';
import 'package:sgc/app/data/blocs/pedido/pedidos_state.dart';
import 'package:sgc/app/pages/tablet/home_page/widgets/item_status.dart';
import '../../../../data/blocs/pedido/pedidos_bloc.dart';

class ColunaStatus extends StatefulWidget {
  final String titulo;
  final Color cor;
  final int idStatus;

  const ColunaStatus({
    super.key,
    required this.titulo,
    required this.cor,
    required this.idStatus,
  });

  @override
  State<ColunaStatus> createState() => _ColunaStatusState();
}

class _ColunaStatusState extends State<ColunaStatus> {
  late final PedidosBloc _pedidosBloc;

  @override
  void initState() {
    super.initState();
    _pedidosBloc = PedidosBloc();
    _carregarDados();
  }

  _carregarDados() {
    _pedidosBloc.inputPedido.add(
      GetPedidosSituacao(
        idSituacao: widget.idStatus,
        acessorios: true,
        chapas: true,
        kits: true,
        perfis: true,
        vidros: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    int quantidade = 0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      width: largura / 3,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.cor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              width: largura / 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    widget.titulo,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Material(
              elevation: 5,
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<PedidosState>(
            stream: _pedidosBloc.outputPedido,
            builder: (context, snapshot) {
              if (snapshot.data is PedidosLoadingState) {
                return Expanded(
                  child: Center(
                    child: LoadingAnimationWidget.waveDots(
                      color: Theme.of(context).indicatorColor,
                      size: 30,
                    ),
                  ),
                );
              } else if (snapshot.data is PedidosLoadedState) {
                List pedidos = snapshot.data!.pedidos;
                quantidade = pedidos.length;
                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      for (var pedido in pedidos)
                        ItemStatus(
                          pedido: pedido,
                        ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Text(
            '$quantidade itens - 0.0 Kg',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
