import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_bloc.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/models/foto_pedido_model.dart';
import '../../../../../../data/enums/icones.dart';
import '../../../../../../models/roteiro_entrega_model.dart';
import '../../../../../../ui/styles/colors_app.dart';
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
    return Scaffold(
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

            final fotosEntregues = _fotos.where(
              (item) => item.situacaoFoto == SituacaoFoto.entregue.index,
            );

            return ListView(
              children: [
                Visibility(
                  visible: fotosSeparando.isNotEmpty,
                  child: const Header(label: '1. Separação'),
                ),
                for (var foto in fotosSeparando) ItemFoto(foto: foto),
                Visibility(
                  visible: fotosConferencia.isNotEmpty,
                  child: const Header(label: '2. Conferência'),
                ),
                for (var foto in fotosConferencia) ItemFoto(foto: foto),
                Visibility(
                  visible: fotosCarregando.isNotEmpty,
                  child: const Header(label: '3. Carregando'),
                ),
                for (var foto in fotosCarregando) ItemFoto(foto: foto),
                Visibility(
                  visible: fotosRoteiroCarregado.isNotEmpty,
                  child: const Header(label: '4. Roteiro Carregado'),
                ),
                for (var foto in fotosRoteiroCarregado) ItemFoto(foto: foto),
                Visibility(
                  visible: fotosEntregues.isNotEmpty,
                  child: const Header(label: '5. Entregues'),
                ),
                for (var foto in fotosEntregues) ItemFoto(foto: foto),
              ],
            );
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String label;
  const Header({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Material(
        elevation: 5,
        color: ColorsApp.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
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
