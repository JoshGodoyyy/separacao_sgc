import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_bloc.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import 'package:sgc/app/pages/phone/camera_page/camera_page.dart';
import 'package:sgc/app/pages/phone/fotos_page/widgets/header.dart';
import 'package:sgc/app/pages/phone/fotos_page/widgets/item_foto.dart';
import 'package:sgc/app/ui/widgets/error_alert.dart';

class FotoPedido extends StatefulWidget {
  final int idPedido;
  final SituacaoFoto situacaoFoto;
  final int idRoteiro;
  final int idCliente;

  const FotoPedido({
    super.key,
    required this.idPedido,
    required this.situacaoFoto,
    required this.idCliente,
    required this.idRoteiro,
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

  _fetchData() {
    _bloc.inputFoto.add(
      GetFotos(
        fotoPedido: FotoPedidoModel(
          0,
          widget.situacaoFoto.index,
          int.parse(
            widget.idPedido.toString(),
          ),
          widget.idRoteiro,
          widget.idCliente,
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
      case SituacaoFoto.carregado:
        situacao = 'Roteiro Carregado';
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

            final fotosSeparando = _fotos.where(
              (item) => item.situacaoFoto == SituacaoFoto.separando.index,
            );

            final fotosConferencia = _fotos.where(
              (item) => item.situacaoFoto == SituacaoFoto.conferencia.index,
            );

            final fotosCarregando = _fotos.where(
              (item) => item.situacaoFoto == SituacaoFoto.carregando.index,
            );

            final fotosRoteiroCarregado = _fotos.where(
              (item) => item.situacaoFoto == SituacaoFoto.carregado.index,
            );
            return RefreshIndicator(
              onRefresh: () => _fetchData(),
              child: ListView(
                children: [
                  Visibility(
                    visible: fotosSeparando.isNotEmpty,
                    child: Column(
                      children: [
                        const Header(label: '1. Separação'),
                        for (var foto in fotosSeparando)
                          ItemFoto(
                            foto: foto,
                            bloc: _bloc,
                            situacao: widget.situacaoFoto.index,
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: fotosConferencia.isNotEmpty,
                    child: Column(
                      children: [
                        const Header(label: '2. Conferência'),
                        for (var foto in fotosConferencia)
                          ItemFoto(
                            foto: foto,
                            bloc: _bloc,
                            situacao: widget.situacaoFoto.index,
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: fotosCarregando.isNotEmpty,
                    child: Column(
                      children: [
                        const Header(label: '3. Carregando'),
                        for (var foto in fotosCarregando)
                          ItemFoto(
                            foto: foto,
                            bloc: _bloc,
                            situacao: widget.situacaoFoto.index,
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: fotosRoteiroCarregado.isNotEmpty,
                    child: Column(
                      children: [
                        const Header(label: '4. Roteiro Carregado'),
                        for (var foto in fotosRoteiroCarregado)
                          ItemFoto(
                            foto: foto,
                            bloc: _bloc,
                            situacao: widget.situacaoFoto.index,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
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
            FloatingActionButton(
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
                              idCliente: widget.idCliente,
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
            )
          ],
        ),
      ),
    );
  }
}
