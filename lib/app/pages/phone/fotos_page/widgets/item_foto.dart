import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../data/blocs/foto_pedido/foto_pedido_bloc.dart';
import '../../../../data/blocs/foto_pedido/foto_pedido_event.dart';
import '../../../../data/enums/icones.dart';
import '../../../../models/foto_pedido_model.dart';
import '../../../../ui/widgets/custom_dialog.dart';

class ItemFoto extends StatelessWidget {
  final FotoPedidoModel foto;
  final FotoPedidoBloc bloc;
  final int situacao;

  const ItemFoto({
    super.key,
    required this.foto,
    required this.bloc,
    required this.situacao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 5,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(
                  titulo: foto.descricao ?? '',
                  conteudo: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.memory(
                      base64Decode(foto.imagem!),
                      width: MediaQuery.of(context).size.width - 16,
                    ),
                  ),
                  tipo: Icones.info,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Ok',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Image.memory(
                  base64Decode(foto.imagem!),
                  width: 60,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: '${foto.idPedido}' != '0',
                        child: Text(
                          'Pedido: ${foto.idPedido}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Visibility(
                        visible: '${foto.idCliente}' != '0',
                        child: Text(
                          softWrap: true,
                          '[${foto.idCliente}] ${foto.nomeCliente}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Visibility(
                        visible: foto.idRoteiro != 0,
                        child: Text(
                          'Roteiro: [${foto.idRoteiro}] ${foto.nomeRoteiro}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text('${foto.descricao}'),
                      Text(
                        'Data: ${foto.dataFoto.toString().split(' ')[0]}',
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: foto.situacaoFoto == situacao,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            titulo: 'Sistema SGC',
                            conteudo: const Text(
                              'Deseja realmente excluir este item?',
                            ),
                            tipo: Icones.pergunta,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  bloc.inputFoto.add(
                                    DeleteFoto(foto: foto),
                                  );

                                  bloc.inputFoto.add(
                                    GetFotos(fotoPedido: foto),
                                  );

                                  Navigator.pop(context);
                                },
                                child: const Text('Sim'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Não'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
