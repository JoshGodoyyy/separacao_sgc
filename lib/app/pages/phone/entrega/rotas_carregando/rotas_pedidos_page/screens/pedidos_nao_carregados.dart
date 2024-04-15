import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_pedidos_page/screens/widgets/pedido_list_item.dart';

import '../../../../../../data/repositories/configuracoes.dart';
import '../../../../../../ui/widgets/error_alert.dart';

class PedidosNaoCarregados extends StatefulWidget {
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;

  const PedidosNaoCarregados({
    super.key,
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
  });

  @override
  State<PedidosNaoCarregados> createState() => _PedidosNaoCarregadosState();
}

class _PedidosNaoCarregadosState extends State<PedidosNaoCarregados> {
  late PedidoRoteiroBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PedidoRoteiroBloc();
    _fetchData();
  }

  _fetchData() async {
    bool separarAgrupamento =
        await Configuracoes().verificaConfiguracaoAgrupamento() == 1
            ? true
            : false;

    _bloc.inputProdutoRoteiroController.add(
      GetPedidosNaoCarregados(
        numeroEntrega: widget.numeroEntrega,
        cepEntrega: widget.cepEntrega,
        idCliente: widget.idCliente,
        idRoteiro: widget.idRoteiro,
        separarAgrupamento: separarAgrupamento,
      ),
    );
  }

  _pedidos(List pedidos) {
    if (pedidos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum pedido',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView(
        children: [
          for (var pedido in pedidos)
            PedidoListItem(
              idPedido: pedido.id,
              numeroEntrega: widget.numeroEntrega,
              cepEntrega: widget.cepEntrega,
              idCliente: widget.idCliente,
              idRoteiro: widget.idRoteiro,
              carregado: pedido.carregado,
              idStatus: pedido.idStatus,
              setorEstoque: pedido.setorEstoque,
              status: pedido.status,
              volumeAcessorio: pedido.volumeAcessorio,
              volumeChapa: pedido.volumeChapa,
              volumePerfil: pedido.volumePerfil,
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
