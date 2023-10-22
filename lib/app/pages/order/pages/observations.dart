import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/widgets/multi_line_text.dart';
import 'package:sgc/app/pages/order/widgets/save_button.dart';

import '/app/models/pedido_model.dart';

class Observations extends StatefulWidget {
  final Pedido pedido;
  const Observations({
    super.key,
    required this.pedido,
  });

  @override
  State<Observations> createState() => _ObservationsState();
}

class _ObservationsState extends State<Observations> {
  final observacoesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          MultiLineText(
            label: 'Observações do Separador',
            controller: observacoesController,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topRight,
            child: saveButton(() {}),
          ),
        ],
      ),
    );
  }
}
