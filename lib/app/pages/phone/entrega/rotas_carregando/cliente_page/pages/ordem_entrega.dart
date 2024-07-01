import 'package:flutter/material.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/repositories/endereco_roteiro_entrega.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import '../../../../../../ui/widgets/error_alert.dart';

class OrdemEntrega extends StatefulWidget {
  final RoteiroEntregaModel dados;
  final bool pedidosNaoOrdenados;
  final List? enderecos;

  const OrdemEntrega({
    super.key,
    required this.dados,
    required this.pedidosNaoOrdenados,
    this.enderecos,
  });

  @override
  State<OrdemEntrega> createState() => _OrdemEntregaState();
}

class _OrdemEntregaState extends State<OrdemEntrega> {
  late EnderecoRoteiroBloc _bloc;
  late List enderecos;

  @override
  void initState() {
    super.initState();
    _bloc = EnderecoRoteiroBloc();
    _fetchData();
    enderecos = [];
  }

  _fetchData() {
    _bloc.inputRoteiroEntregaController.add(
      GetEnderecosRoteiro(
        idRoteiro: int.parse(
          widget.dados.id.toString(),
        ),
      ),
    );
  }

  void reordenarEnderecos(int oldIndex, int newIndex) {
    setState(
      () {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        final item = enderecos.removeAt(oldIndex);
        enderecos.insert(newIndex, item);
      },
    );

    _salvarPosicoes();
  }

  _salvarPosicoes() {
    _bloc.inputRoteiroEntregaController.add(
      AtualizarPosicao(
        idRoteiro: int.parse(
          widget.dados.id.toString(),
        ),
        enderecos: enderecos,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.pedidosNaoOrdenados
          ? null
          : AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                widget.dados.nome!,
              ),
              centerTitle: true,
            ),
      body: SafeArea(
        child: StreamBuilder<EnderecoRoteiroState>(
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
                int posicao = 0;

                for (var endereco in enderecos) {
                  if (endereco.posicao == 0 && posicao == 0) {
                    endereco.posicao = posicao;
                  }

                  posicao++;
                }

                EnderecoRoteiroEntrega().atualizarOrdem(
                  int.parse(
                    widget.dados.id.toString(),
                  ),
                  enderecos,
                );

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ReorderableListView(
                          children: showList(context),
                          onReorder: (oldIndex, newIndex) =>
                              reordenarEnderecos(oldIndex, newIndex),
                        ),
                      ),
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ordem de entrega',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomDialog(
                          titulo: 'SGC Mobile',
                          descricao:
                              'Arraste os itens para ordenar a rota de entrega. Isso impactará na ordem de carregamento do caminhão',
                          tipo: Icones.info,
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.question_mark_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _salvarPosicoes();
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.check,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> showList(BuildContext context) {
    return [
      for (var endereco in enderecos)
        Padding(
          key: ValueKey(endereco),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Material(
                elevation: 5,
                shape: const CircleBorder(),
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('${endereco.posicao + 1}'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          endereco.enderecoCompleto(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('[${endereco.idCliente}] ${endereco.fantasia}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ];
  }
}
