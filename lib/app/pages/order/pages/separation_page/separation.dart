import 'package:flutter/material.dart';

import 'package:sgc/app/pages/order/widgets/save_button.dart';

import '../../../../models/order_model.dart';
import 'widgets/details.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // for (var group in widget.pedido.grupos)
          //   GroupItem(
          //     item: group,
          //     onTap: () => showModal(
          //       widget.context,
          //       group,
          //     ).then((value) => setState(() {})),
          //   ),
          Details(
            pedido: widget.pedido,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: saveButton(() {}),
          ),
        ],
      ),
    );
  }
}
