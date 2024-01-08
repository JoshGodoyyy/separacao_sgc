import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_bloc.dart';
import 'package:sgc/app/data/repositories/grupo.dart';
import 'package:sgc/app/pages/order/pages/separation_page/widgets/group_item.dart';
import 'package:sgc/app/pages/order/pages/separation_page/widgets/modal.dart';

import 'package:sgc/app/pages/order/widgets/save_button.dart';

import '../../../../config/app_config.dart';
import '../../../../models/pedido_model.dart';
import 'widgets/details.dart';

class Separation extends StatefulWidget {
  final PedidoModel pedido;
  final BuildContext context;
  const Separation({
    super.key,
    required this.pedido,
    required this.context,
  });

  @override
  State<Separation> createState() => _SeparationState();
}

class _SeparationState extends State<Separation> {
  late int tipoProduto;
  late final PedidoBloc _pedidoBloc;
  final volumeAcessorioController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeChapasController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final pesoAcessorioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pedidoBloc = PedidoBloc();
  }

  Future<List<dynamic>> fetchData() async {
    final result = Provider.of<AppConfig>(context, listen: false);

    if (result.accessories && result.profiles) {
      tipoProduto = 0;
    } else if (result.profiles) {
      tipoProduto = 2;
    } else if (result.accessories) {
      tipoProduto = 3;
    }
    return Grupo().fetchGrupos(
      int.parse(
        widget.pedido.id.toString(),
      ),
      tipoProduto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              shrinkWrap: true,
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index >= snapshot.data!.length) {
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
                            child: saveButton(() {})),
                      ),
                    ],
                  );
                } else {
                  var grupo = snapshot.data![index];
                  return GroupItem(
                    item: grupo,
                    onTap: () {
                      showModal(
                        widget.context,
                        grupo,
                        int.parse(
                          widget.pedido.id.toString(),
                        ),
                        tipoProduto,
                      );
                    },
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
