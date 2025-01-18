import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_bloc.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_event.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_state.dart';
import 'package:sgc/app/models/group_model.dart';
import '../../../../../../models/pedido_model.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import 'widgets/details.dart';
import 'widgets/group_item.dart';
import 'widgets/modal.dart';

class Separation extends StatefulWidget {
  final BuildContext ancestralContext;
  final PedidoModel pedido;
  final bool perfis;
  final bool acessorios;
  final bool chapas;
  final bool vidros;
  final bool kits;
  final TextEditingController volumeAcessorioController;
  final TextEditingController volumeAluminioController;
  final TextEditingController volumeChapasController;
  final TextEditingController observacoesSeparacaoController;
  final TextEditingController observacoesSeparadorController;
  final TextEditingController setorSeparacaoController;
  final TextEditingController pesoAcessorioController;
  final TextEditingController pesoController;

  const Separation({
    super.key,
    required this.ancestralContext,
    required this.pedido,
    required this.perfis,
    required this.acessorios,
    required this.chapas,
    required this.vidros,
    required this.kits,
    required this.volumeAcessorioController,
    required this.volumeAluminioController,
    required this.volumeChapasController,
    required this.observacoesSeparacaoController,
    required this.observacoesSeparadorController,
    required this.setorSeparacaoController,
    required this.pesoAcessorioController,
    required this.pesoController,
  });

  @override
  State<Separation> createState() => _SeparationState();
}

class _SeparationState extends State<Separation> {
  late final GrupoBloc _grupoBloc;

  @override
  void initState() {
    super.initState();
    _grupoBloc = GrupoBloc();
    _fetchGrupos();
  }

  _fetchGrupos() {
    _grupoBloc.inputGrupo.add(
      GetGrupo(
        idPedido: int.parse(
          widget.pedido.id.toString(),
        ),
        acessorios: widget.acessorios,
        chapas: widget.chapas,
        kits: widget.kits,
        perfis: widget.perfis,
        vidros: widget.vidros,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<GrupoState>(
        stream: _grupoBloc.outputGrupo,
        builder: (context, snapshot) {
          if (snapshot.data is GrupoLoadingState) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: Theme.of(context).indicatorColor,
                size: 30,
              ),
            );
          } else if (snapshot.data is GrupoLoadedState) {
            List grupos = snapshot.data?.grupos ?? [];
            return RefreshIndicator(
              onRefresh: () async {
                _fetchGrupos();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: grupos.length + 1,
                itemBuilder: (context, index) {
                  if (index >= grupos.length) {
                    return Column(
                      children: [
                        Details(
                          pedido: widget.pedido,
                          volumeAcessorio: widget.volumeAcessorioController,
                          volumeAluminio: widget.volumeAluminioController,
                          volumeChapa: widget.volumeChapasController,
                          observacoesSeparacao:
                              widget.observacoesSeparacaoController,
                          observacoesSeparador:
                              widget.observacoesSeparadorController,
                          setorSeparacao: widget.setorSeparacaoController,
                          pesoAcessorio: widget.pesoAcessorioController,
                        ),
                      ],
                    );
                  } else {
                    GrupoModel grupo = grupos[index];
                    return GroupItem(
                      item: grupo,
                      onTap: () {
                        showModal(
                          widget.ancestralContext,
                          _grupoBloc,
                          grupo,
                          int.parse(
                            widget.pedido.id.toString(),
                          ),
                          widget.perfis,
                          widget.acessorios,
                          widget.chapas,
                          widget.vidros,
                          widget.kits,
                        );
                      },
                    );
                  }
                },
              ),
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
