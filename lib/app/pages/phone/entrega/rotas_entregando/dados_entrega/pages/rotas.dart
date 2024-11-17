import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/repositories/confirmacao_entrega.dart';
import 'package:sgc/app/data/repositories/pedido_roteiro.dart';
import 'package:sgc/app/models/confirmacao_entrega_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_entregando/dados_entrega/pages/widgets/modal_entrega.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

import '../../../../../../config/user.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import '../../../../../../data/repositories/configuracoes.dart';
import '../../../../../../data/repositories/historico_pedido.dart';
import '../../../../../../models/endereco_roteiro_entrega_model.dart';
import '../../../../../../models/historico_pedido_model.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import '../../pedidos_rota.dart';

class Rotas extends StatefulWidget {
  final RoteiroEntregaModel roteiro;

  const Rotas({
    super.key,
    required this.roteiro,
  });

  @override
  State<Rotas> createState() => _RotasState();
}

class _RotasState extends State<Rotas> {
  final DateFormat _data = DateFormat('yyyy-MM-dd HH:mm:ss');

  late EnderecoRoteiroBloc _bloc;
  late List enderecos;

  @override
  void initState() {
    super.initState();
    _bloc = EnderecoRoteiroBloc();
    _fetchData();
  }

  _fetchData() {
    _bloc.inputRoteiroEntregaController.add(
      GetEnderecosRoteiro(
        idRoteiro: int.parse(
          widget.roteiro.id.toString(),
        ),
      ),
    );
  }

  String _endereco(EnderecoRoteiroEntregaModel data) {
    if (data.endereco == null) {
      return '';
    } else {
      if (data.complemento != '') {
        return '${data.logradouro} ${data.endereco}, ${data.numero} - ${data.complemento} - ${data.bairro} - ${data.cidade} - ${data.estado} - ${data.cep}.';
      } else {
        return '${data.logradouro} ${data.endereco}, ${data.numero} - ${data.bairro} - ${data.cidade} - ${data.estado} - ${data.cep}.';
      }
    }
  }

  _entregarPedido(endereco) async {
    final nomeController = TextEditingController();
    final rgController = TextEditingController();
    final cpfController = TextEditingController();

    bool separarAgrupamento =
        await Configuracoes().verificaConfiguracaoAgrupamento() == 1;

    var pedidos = await PedidoRoteiro().fetchPedidosCarregados(
      endereco.numero,
      endereco.cep,
      endereco.idCliente,
      endereco.idRoteiroEntrega,
      separarAgrupamento,
    );

    if (mounted) {
      showModal(
        context,
        nomeController,
        rgController,
        cpfController,
        () {
          if (nomeController.text == '' &&
              (rgController.text == '' || cpfController.text == '')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Você precisa identificar o responsável de recebimento',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsApp.darkElementColor,
              ),
            );

            return;
          }

          _confirmarEntrega(
            nomeController.text,
            rgController.text,
            cpfController.text,
            pedidos,
          );

          _salvarEntrega(endereco, pedidos);
        },
      );
    }
  }

  _confirmarEntrega(
    nome,
    rg,
    cpf,
    pedidos,
  ) async {
    List<ConfirmacaoEntregaModel> itens = [];
    for (var pedido in pedidos) {
      itens.add(
        ConfirmacaoEntregaModel(
          pedido.id,
          nome,
          rg,
          cpf,
        ),
      );
    }

    await ConfirmacaoEntrega().confirmar(itens);
  }

  _salvarEntrega(endereco, pedidos) async {
    _bloc.inputRoteiroEntregaController.add(
      EntregarPedido(
        idRoteiro: int.parse(
          widget.roteiro.id.toString(),
        ),
        cep: endereco.cep.toString(),
        numero: endereco.numero.toString(),
        idSituacao: 11,
        idCliente: int.parse(
          endereco.idCliente.toString(),
        ),
      ),
    );

    List<HistoricoPedidoModel> pedidosHistorico = [];

    for (var pedido in pedidos) {
      pedidosHistorico.add(
        HistoricoPedidoModel(
          idPedido: pedido.id,
          idStatus: 11,
          status: 'ENTREGUE',
          chaveFuncionario: UserConstants().idLiberacao,
          data: _data.format(
            DateTime.now(),
          ),
          idUsuario: UserConstants().idUsuario,
        ),
      );
    }

    await HistoricoPedido().adicionarHistoricos(pedidosHistorico);
  }

  _retornarPedido(endereco) async {
    _bloc.inputRoteiroEntregaController.add(
      EntregarPedido(
        idRoteiro: int.parse(
          widget.roteiro.id.toString(),
        ),
        cep: endereco.cep.toString(),
        numero: endereco.numero.toString(),
        idSituacao: 5,
        idCliente: int.parse(
          endereco.idCliente.toString(),
        ),
      ),
    );

    bool separarAgrupamento =
        await Configuracoes().verificaConfiguracaoAgrupamento() == 1;

    var pedidos = await PedidoRoteiro().fetchPedidosCarregados(
      endereco.numero,
      endereco.cep,
      endereco.idCliente,
      endereco.idRoteiroEntrega,
      separarAgrupamento,
    );

    List<HistoricoPedidoModel> pedidosHistorico = [];

    for (var pedido in pedidos) {
      pedidosHistorico.add(
        HistoricoPedidoModel(
          idPedido: pedido.id,
          idStatus: 5,
          status: 'OK',
          chaveFuncionario: UserConstants().idLiberacao,
          data: _data.format(
            DateTime.now(),
          ),
          idUsuario: UserConstants().idUsuario,
        ),
      );
    }

    await HistoricoPedido().adicionarHistoricos(pedidosHistorico);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EnderecoRoteiroState>(
      stream: _bloc.outputRoteiroEntregaController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data is EnderecoRoteiroLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 46),
              child: LinearProgressIndicator(),
            ),
          );
        } else if (snapshot.data is EnderecoRoteiroLoadedState) {
          enderecos = snapshot.data?.enderecos ?? [];

          if (enderecos.isEmpty) {
            return const Center(
              child: Text('Nada por aqui'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        for (var endereco in enderecos)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Material(
                                  elevation: 5,
                                  color: endereco.idSituacao == 11
                                      ? Colors.green
                                      : Theme.of(context).primaryColor,
                                  shape: const CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text('${endereco.posicao + 1}'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Slidable(
                                    startActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) =>
                                              endereco.idSituacao == 5 ||
                                                      endereco.idSituacao == 10
                                                  ? _entregarPedido(endereco)
                                                  : _retornarPedido(endereco),
                                          backgroundColor:
                                              endereco.idSituacao == 11
                                                  ? Colors.red
                                                  : Colors.green,
                                          foregroundColor: Colors.white,
                                          icon: endereco.idSituacao == 11
                                              ? Icons.undo
                                              : Icons.check,
                                          label: endereco.idSituacao == 11
                                              ? 'Retornar'
                                              : 'Entregue',
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: endereco.idSituacao == 11
                                          ? Colors.green
                                          : Theme.of(context).primaryColor,
                                      child: InkWell(
                                        onTap: () {
                                          mostrarPedidos(
                                            context,
                                            endereco,
                                            int.parse(
                                              widget.roteiro.id.toString(),
                                            ),
                                          );
                                        },
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _endereco(endereco),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                maxLines: 5,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(endereco.fantasia),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          return ErrorAlert(
            message: snapshot.error.toString(),
          );
        }
      },
    );
  }

  Future<dynamic> mostrarPedidos(
    BuildContext context,
    endereco,
    int idRoteiro,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return PedidosRota(
          endereco: endereco,
          idRoteiro: idRoteiro,
        );
      },
    );
  }
}
