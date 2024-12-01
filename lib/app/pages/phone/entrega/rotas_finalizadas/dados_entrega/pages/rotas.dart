import 'package:flutter/material.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import '../../../../../../data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import '../../../../../../models/endereco_roteiro_entrega_model.dart';
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
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PedidosRota(
          endereco: endereco,
          idRoteiro: idRoteiro,
        );
      },
    );
  }
}
