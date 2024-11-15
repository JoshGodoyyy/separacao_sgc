import 'package:flutter/material.dart';

import '../../../../data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';
import '../../../../data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import '../../../../data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import '../../../../data/repositories/configuracoes.dart';
import '../../../../ui/widgets/error_alert.dart';

class PedidosRota extends StatefulWidget {
  final dynamic endereco;
  final int idRoteiro;

  const PedidosRota({
    super.key,
    required this.endereco,
    required this.idRoteiro,
  });

  @override
  State<PedidosRota> createState() => _PedidosRotaState();
}

class _PedidosRotaState extends State<PedidosRota> {
  late PedidoRoteiroBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PedidoRoteiroBloc();
    _fetchPedidos();
  }

  _fetchPedidos() async {
    bool separarAgrupamento =
        await Configuracoes().verificaConfiguracaoAgrupamento() == 1;

    _bloc.inputProdutoRoteiroController.add(
      GetPedidosCarregados(
        numeroEntrega: widget.endereco.numero,
        cepEntrega: widget.endereco.cep,
        idCliente: widget.endereco.idCliente,
        idRoteiro: widget.idRoteiro,
        separarAgrupamento: separarAgrupamento,
      ),
    );
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

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        '${widget.endereco.logradouro} ${widget.endereco.endereco}, ${widget.endereco.numero}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Pedidos:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    for (var pedido in pedidos)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('- ${pedido.id}'),
                          Text(
                            '   Volume total: ${pedido.volumeAcessorio + pedido.volumeChapa + pedido.volumePerfil}',
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                  ],
                ),
              ),
            ),
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
