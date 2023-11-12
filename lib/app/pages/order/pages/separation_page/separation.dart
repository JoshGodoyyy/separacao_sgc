import 'package:flutter/material.dart';

import 'package:sgc/app/pages/order/widgets/save_button.dart';

import '../../../../models/order_model.dart';
import 'widgets/details.dart';
import 'widgets/groups_item.dart';
import 'widgets/modal.dart';

class Separation extends StatefulWidget {
  final Pedido pedido;
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
  final pesoAcessorioController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeAcessorioController = TextEditingController();
  final volumeChapaController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (var group in widget.pedido.grupos)
            GroupItem(
              item: group,
              onTap: () => showModal(
                widget.context,
                group,
              ).then((value) => setState(() {})),
            ),
          Details(
            setorSeparacao: setorSeparacaoController,
            pesoAcessorio: pesoAcessorioController,
            volumeAcessorio: volumeAcessorioController,
            volumeAluminio: volumeAluminioController,
            volumeChapas: volumeChapaController,
            observacoesSeparacao: observacoesSeparacaoController,
            observacoesSeparador: observacoesSeparadorController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 90, 12),
            child: saveButton(() {}),
          ),
        ],
      ),
    );
  }
}
