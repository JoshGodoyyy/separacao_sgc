import 'package:flutter/material.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/repositories/endereco_roteiro_entrega.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import '../../../../../../models/endereco_roteiro_entrega_model.dart';
import '../../../../../../ui/widgets/error_alert.dart';

class OrdemEntrega extends StatefulWidget {
  final RoteiroEntregaModel dados;
  final bool pedidosNaoOrdenados;

  const OrdemEntrega({
    super.key,
    required this.dados,
    required this.pedidosNaoOrdenados,
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

        _bloc.inputRoteiroEntregaController.add(
          AtualizarPosicao(
            idRoteiro: int.parse(
              widget.dados.id.toString(),
            ),
            enderecos: enderecos,
          ),
        );
      },
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
                      Material(
                        elevation: 5,
                        color: ColorsApp.primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ordem de entrega',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const CustomDialog(
                                          titulo: 'Sistema SGC',
                                          descricao:
                                              'Arraste os itens para ordenar a rota de entrega. Isso impactará na ordem de carregamento do caminhão',
                                          tipo: Icones.info,
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.question_mark_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReorderableListView(
                          children: [
                            for (var endereco in enderecos)
                              Padding(
                                key: ValueKey(endereco),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Text('${endereco.posicao + 1}'),
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
                                  ],
                                ),
                              ),
                          ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Concluído'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
