import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_bloc.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_event.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_state.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_bloc.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_event.dart';
import 'package:sgc/app/models/group_model.dart';
import 'package:sgc/app/pages/order/pages/separation_page/widgets/group_item.dart';
import 'package:sgc/app/pages/order/pages/separation_page/widgets/modal.dart';
import 'package:sgc/app/pages/order/widgets/save_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/widgets/error_alert.dart';
import 'widgets/details.dart';

class Separation extends StatefulWidget {
  final BuildContext ancestralContext;
  final PedidoModel pedido;
  final int tipoProduto;

  const Separation({
    super.key,
    required this.ancestralContext,
    required this.pedido,
    required this.tipoProduto,
  });

  @override
  State<Separation> createState() => _SeparationState();
}

class _SeparationState extends State<Separation> {
  late final PedidoBloc _pedidoBloc;
  late final GrupoBloc _grupoBloc;

  final volumeAcessorioController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeChapasController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final pesoAcessorioController = TextEditingController();
  final pesoController = TextEditingController();

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
        idTipoProduto: widget.tipoProduto,
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
                itemCount: grupos.length + 1,
                itemBuilder: (context, index) {
                  if (index >= grupos.length) {
                    return Column(
                      children: [
                        Details(
                          pedido: widget.pedido,
                          volumeAcessorio: volumeAcessorioController,
                          volumeAluminio: volumeAluminioController,
                          volumeChapa: volumeChapasController,
                          observacoesSeparacao: observacoesSeparacaoController,
                          observacoesSeparador: observacoesSeparadorController,
                          setorSeparacao: setorSeparacaoController,
                          pesoAcessorio: pesoAcessorioController,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: saveButton(
                              () {
                                if (volumeAcessorioController.text == '') {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                        message: 'Preencher Volume Acessório'),
                                  );
                                  return;
                                }

                                if (volumeAluminioController.text == '') {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                        message: 'Preencher Volume Aluminio'),
                                  );
                                  return;
                                }

                                if (volumeChapasController.text == '') {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                        message: 'Preencher Volume Chapas'),
                                  );
                                  return;
                                }

                                if (pesoAcessorioController.text == '') {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                        message: 'Preencher Peso Acessório'),
                                  );
                                  return;
                                }

                                _pedidoBloc.inputPedido.add(
                                  UpdatePedido(
                                    volAcessorio: double.parse(
                                        volumeAcessorioController.text),
                                    volAlum: double.parse(
                                        volumeAluminioController.text),
                                    volChapa: double.parse(
                                        volumeChapasController.text),
                                    obsSeparacao:
                                        observacoesSeparacaoController.text,
                                    obsSeparador:
                                        observacoesSeparadorController.text,
                                    setorEstoque: setorSeparacaoController.text,
                                    pesoAcessorio: double.parse(
                                        pesoAcessorioController.text),
                                    idPedido: int.parse(
                                      widget.pedido.id.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
                          widget.tipoProduto,
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
