import 'package:flutter/material.dart';

import '../../../../../../data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';
import '../../../../../../data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import '../../../../../../data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import '../../../../../../data/repositories/configuracoes.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import 'widgets/pedido_list_item.dart';

class PedidosCarregados extends StatefulWidget {
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;

  const PedidosCarregados({
    super.key,
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idRoteiro,
    required this.idCliente,
  });

  @override
  State<PedidosCarregados> createState() => _PedidosCarregadosState();
}

class _PedidosCarregadosState extends State<PedidosCarregados> {
  late PedidoRoteiroBloc _bloc;
  bool _selecionarTodos = false;
  List _todosPedidos = [];

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
      GetPedidosCarregados(
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
      _todosPedidos = pedidos;

      return Expanded(
        child: ListView(
          children: [
            for (var pedido in pedidos)
              Row(
                children: [
                  Checkbox(
                      value: pedido.selecionado ?? false,
                      onChanged: (value) {
                        setState(() {
                          pedido.selecionado = value ?? false;
                        });
                      }),
                  Expanded(
                    child: PedidoListItem(
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
                      selecionado: pedido.selecionado ?? false,
                      pesoTotal: pedido.pesoTotal ?? 0,
                      tratamento: pedido.tratamento ?? '',
                      tratamentoItens: pedido.tratamentoItens ?? '',
                      bloc: _bloc,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ProdutoRoteiroState>(
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

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _selecionarTodos,
                        onChanged: (value) {
                          setState(() {
                            _selecionarTodos = !_selecionarTodos;
                            for (var pedido in pedidos) {
                              pedido.selecionado = _selecionarTodos;
                            }
                          });
                        },
                      ),
                      const Text('Selecionar todos'),
                    ],
                  ),
                ),
                _pedidos(pedidos),
                const SizedBox(height: 80),
              ],
            );
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          bool separarAgrupamento =
              await Configuracoes().verificaConfiguracaoAgrupamento() == 1
                  ? true
                  : false;

          for (var pedido
              in _todosPedidos.where((item) => item.selecionado == true)) {
            _bloc.inputProdutoRoteiroController.add(
              DescarregarPedido(
                idPedido: pedido.id,
                numeroEntrega: widget.numeroEntrega,
                cepEntrega: widget.cepEntrega,
                idCliente: widget.idCliente,
                idRoteiro: widget.idRoteiro,
                separarAgrupamento: separarAgrupamento,
              ),
            );
          }
        },
        label: const Text('Descarregar selecionados'),
      ),
    );
  }
}
