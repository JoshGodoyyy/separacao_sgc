import 'package:flutter/material.dart';
import '../../../../../../models/roteiro_entrega_model.dart';
import 'dart:convert';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_bloc.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import '../../../../../../data/enums/icones.dart';
import '../../../../../../ui/widgets/custom_dialog.dart';
import '../../../../../../ui/widgets/error_alert.dart';

class Galeria extends StatefulWidget {
  final RoteiroEntregaModel roteiro;
  const Galeria({
    super.key,
    required this.roteiro,
  });

  @override
  State<Galeria> createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  late FotoPedidoBloc _bloc;
  late List _fotos;

  @override
  void initState() {
    super.initState();
    _bloc = FotoPedidoBloc();
    _fotos = [];
    _fetchData();
  }

  _fetchData() {
    _bloc.inputFoto.add(
      GetFotos(
        fotoPedido: FotoPedidoModel(
          0,
          SituacaoFoto.entregue.index,
          0,
          widget.roteiro.id,
          0,
          '',
          '',
          '',
          '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FotoPedidoState>(
      stream: _bloc.outputFoto,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data is FotoPedidoLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 46),
              child: LinearProgressIndicator(),
            ),
          );
        } else if (snapshot.data is FotoPedidoLoadedState) {
          _fotos = snapshot.data?.fotos ?? [];

          final fotosEntregues = _fotos.where(
            (item) => item.situacaoFoto == SituacaoFoto.entregue.index,
          );

          return ListView(
            children: [
              for (var foto in fotosEntregues) ItemFoto(foto: foto),
            ],
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

class ItemFoto extends StatelessWidget {
  final FotoPedidoModel foto;

  const ItemFoto({
    super.key,
    required this.foto,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
