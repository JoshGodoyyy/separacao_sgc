import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_pedidos_page/screens/widgets/pedido_list_item.dart';

import '../../../../../../data/enums/situacao_foto.dart';
import '../../../../../../data/repositories/configuracoes.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import '../../../../fotos_page/foto_pedido.dart';

class PedidosNaoCarregados extends StatefulWidget {
  final BuildContext mainContext;
  final String numeroEntrega;
  final String cepEntrega;
  final int idRoteiro;
  final int idCliente;

  const PedidosNaoCarregados({
    super.key,
    required this.mainContext,
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
      return const Expanded(
        child: Center(
          child: Text(
            'Nenhum pedido',
            style: TextStyle(fontSize: 24),
          ),
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
                      setState(
                        () {
                          pedido.selecionado = value ?? false;
                        },
                      );
                    },
                  ),
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
                      status: pedido.status ?? '',
                      volumeAcessorio: pedido.volumeAcessorio,
                      volumeChapa: pedido.volumeChapa,
                      volumePerfil: pedido.volumePerfil,
                      selecionado: pedido.selecionado ?? false,
                      pesoTotal: pedido.pesoTotal ?? 0,
                      tratamento: pedido.tratamento ?? '',
                      tratamentoItens: pedido.tratamentoItens ?? '',
                      observacoesCarregador: pedido.observacoesCarregador ?? '',
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
                _pedidos(pedidos),
                Material(
                  color: Theme.of(context).primaryColor,
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
              ],
            );
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => FotoPedido(
                      idPedido: int.parse(
                        widget.idCliente.toString(),
                      ),
                      situacaoFoto: SituacaoFoto.carregando,
                      idRoteiro: widget.idRoteiro,
                      idCliente: int.parse(
                        widget.idCliente.toString(),
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.camera_alt,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                bool separarAgrupamento =
                    await Configuracoes().verificaConfiguracaoAgrupamento() == 1
                        ? true
                        : false;

                for (var pedido in _todosPedidos.where((item) =>
                    item.selecionado == true && item.idStatus == 5 ||
                    item.idStatus == 10)) {
                  _bloc.inputProdutoRoteiroController.add(
                    CarregarPedido(
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
              child: const Row(
                children: [
                  Icon(
                    Icons.app_registration_rounded,
                  ),
                  SizedBox(width: 16),
                  Text('Carregar selecionados'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
