import 'package:flutter/material.dart';

import '../../../../data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import '../../../../data/blocs/endereco_roteiro/pedido_endereco_bloc.dart';
import '../../../../data/blocs/endereco_roteiro/pedido_endereco_roteiro_state.dart';
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
  late PedidoEnderecoRoteiroBloc _pedidoEnderecoRoteiroBloc;

  @override
  void initState() {
    super.initState();
    _pedidoEnderecoRoteiroBloc = PedidoEnderecoRoteiroBloc();
    _fetchPedidos();
  }

  _fetchPedidos() {
    _pedidoEnderecoRoteiroBloc.inputRoteiroEntregaController.add(
      GetPedidos(
          cep: widget.endereco.cep,
          numero: widget.endereco.numero,
          idRoteiro: widget.idRoteiro),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PedidoEnderecoRoteiroState>(
      stream: _pedidoEnderecoRoteiroBloc.outputRoteiroEntregaController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data is PedidoEnderecoRoteiroLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 46),
              child: LinearProgressIndicator(),
            ),
          );
        } else if (snapshot.data is PedidoEnderecoRoteiroLoadedState) {
          List pedidos = snapshot.data?.pedidos ?? [];

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
