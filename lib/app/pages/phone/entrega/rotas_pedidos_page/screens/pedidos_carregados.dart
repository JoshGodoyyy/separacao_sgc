import 'package:flutter/material.dart';

import '../../../../../data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';
import '../../../../../data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import '../../../../../data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import '../../../../../models/pedido_roteiro_model.dart';
import '../../../../../ui/widgets/error_alert.dart';
import 'widgets/pedido_list_item.dart';

class PedidosCarregados extends StatefulWidget {
  final int idRoteiro;
  final int idCliente;
  const PedidosCarregados({
    super.key,
    required this.idRoteiro,
    required this.idCliente,
  });

  @override
  State<PedidosCarregados> createState() => _PedidosCarregadosState();
}

class _PedidosCarregadosState extends State<PedidosCarregados> {
  late PedidoRoteiroBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PedidoRoteiroBloc();
    _fetchData();
  }

  _fetchData() {
    var pedido = PedidoRoteiroModel(
      id: 0,
      idRoteiroEntrega: widget.idRoteiro,
      idCliente: widget.idCliente,
      carregado: 0,
    );

    _bloc.inputProdutoRoteiroController.add(
      GetPedidosCarregados(pedido: pedido),
    );
  }

  _pedidos(List pedidos) {
    if (pedidos.isEmpty) {
      return const Center(
        child: Text(
          'Nada por aqui 👀',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView(
        children: [
          for (var pedido in pedidos)
            PedidoListItem(
              pedido: pedido,
              bloc: _bloc,
            ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProdutoRoteiroState>(
      stream: _bloc.outputProdutoRoteiroController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data is ProdutoRoteiroLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 46),
              child: LinearProgressIndicator(),
            ),
          );
        } else if (snapshot.data is ProdutoRoteiroLoadedState) {
          List pedidos = snapshot.data?.produtos ?? [];
          return _pedidos(pedidos);
        } else {
          return ErrorAlert(
            message: snapshot.error.toString(),
          );
        }
      },
    );
  }
}
