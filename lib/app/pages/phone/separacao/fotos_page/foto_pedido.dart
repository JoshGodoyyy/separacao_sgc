import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_bloc.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import 'package:sgc/app/pages/phone/camera_page/camera_page.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:sgc/app/ui/widgets/error_alert.dart';

class FotoPedido extends StatefulWidget {
  final int idPedido;
  final SituacaoFoto situacaoFoto;
  final int idRoteiro;
  const FotoPedido({
    super.key,
    required this.idPedido,
    required this.situacaoFoto,
    this.idRoteiro = 0,
  });

  @override
  State<FotoPedido> createState() => _FotoPedidoState();
}

class _FotoPedidoState extends State<FotoPedido> {
  late FotoPedidoBloc _bloc;
  late List _fotos;

  @override
  void initState() {
    super.initState();
    _bloc = FotoPedidoBloc();
    _fetchData();
    _fotos = [];
  }

  _fetchData() async {
    _bloc.inputFoto.add(
      GetFotos(
        fotoPedido: FotoPedidoModel(
          0,
          widget.situacaoFoto.index,
          int.parse(
            widget.idPedido.toString(),
          ),
          widget.idRoteiro,
          '',
          '',
          '',
        ),
      ),
    );
  }

  String _situacao() {
    String situacao = '';
    switch (widget.situacaoFoto) {
      case SituacaoFoto.separando:
        situacao = 'Separando';
        break;
      case SituacaoFoto.conferencia:
        situacao = 'Conferência';
        break;
      case SituacaoFoto.carregando:
        situacao = 'Carregando';
        break;
      case SituacaoFoto.entregue:
        situacao = 'Entregue';
        break;
      default:
        break;
    }
    return situacao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          children: [
            Text('Fotos - ${widget.idPedido}'),
            Text(
              _situacao(),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<FotoPedidoState>(
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
            return ListView(
              children: [
                for (var foto in _fotos)
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                                titulo: foto.descricao,
                                conteudo: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.memory(
                                    base64Decode(foto.imagem),
                                    width:
                                        MediaQuery.of(context).size.width - 16,
                                  ),
                                ),
                                tipo: Icones.info,
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
                                base64Decode(foto.imagem),
                                width: 60,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Descrição: ${foto.descricao}'),
                                  Text(
                                    'Data: ${foto.dataFoto.toString().split(' ')[0]}',
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        titulo: 'Sistema SGC',
                                        conteudo: Column(
                                          children: [
                                            const Text(
                                              'Deseja realmente excluir este item?',
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    foto.situacaoFoto = widget
                                                        .situacaoFoto.index;
                                                    _bloc.inputFoto.add(
                                                      DeleteFoto(foto: foto),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Sim'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Não'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        tipo: Icones.pergunta,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cameras = await availableCameras();

          final firstCamera = cameras.first;

          WidgetsBinding.instance.addPostFrameCallback(
            (timestamp) {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => CameraPage(
                        camera: firstCamera,
                        idPedido: widget.idPedido,
                        situacaoFoto: widget.situacaoFoto,
                        idRoteiro: widget.idRoteiro,
                      ),
                    ),
                  )
                  .then(
                    (value) => _fetchData(),
                  );
            },
          );
        },
        child: const Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}
