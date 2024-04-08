import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import 'package:sgc/app/models/endereco_roteiro_entrega_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_entregando/pedidos_rota.dart';
import 'package:sgc/app/ui/widgets/item_field.dart';

import '../../../../../ui/widgets/error_alert.dart';

class DadosEntrega extends StatefulWidget {
  final RoteiroEntregaModel roteiro;
  const DadosEntrega({
    super.key,
    required this.roteiro,
  });

  @override
  State<DadosEntrega> createState() => _DadosEntregaState();
}

class _DadosEntregaState extends State<DadosEntrega> {
  late EnderecoRoteiroBloc _bloc;
  late List enderecos;

  final nomeMotoristaController = TextEditingController();
  final kmInicialController = TextEditingController();
  final horaSaidaController = TextEditingController();
  final ajudanteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = EnderecoRoteiroBloc();
    _fetchData();

    final horario = DateFormat('HH:mm:ss');

    nomeMotoristaController.text = widget.roteiro.nomeMotorista ?? '';
    kmInicialController.text = widget.roteiro.kmInicial.toString();
    ajudanteController.text = widget.roteiro.ajudante ?? '';

    if (widget.roteiro.horaSaida != null) {
      horaSaidaController.text = horario.format(
        DateTime.parse(widget.roteiro.horaSaida!),
      );
    } else {
      horaSaidaController.text = '';
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roteiro.nome ?? ''),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder<EnderecoRoteiroState>(
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
                    ItemField(
                      label: 'Motorista',
                      controller: nomeMotoristaController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ItemField(
                            label: 'Km Inicial',
                            controller: kmInicialController,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ItemField(
                            label: 'Saída',
                            controller: horaSaidaController,
                          ),
                        ),
                      ],
                    ),
                    ItemField(
                      label: 'Ajudante',
                      controller: ajudanteController,
                    ),
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
                                    color: endereco.entregue == 1
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
                                      startActionPane: endereco.entregue == 0
                                          ? ActionPane(
                                              motion: const BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (_) {
                                                    _bloc
                                                        .inputRoteiroEntregaController
                                                        .add(
                                                      EntregarPedido(
                                                        idRoteiro: int.parse(
                                                          widget.roteiro.id
                                                              .toString(),
                                                        ),
                                                        idPedido: int.parse(
                                                          endereco.id
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.check,
                                                  label: 'Entregue',
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                )
                                              ],
                                            )
                                          : null,
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: endereco.entregue == 1
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
      ),
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
