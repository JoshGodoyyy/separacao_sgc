import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/widgets/save_button.dart';

import '../../widgets/multi_line_text.dart';
import '/app/models/pedido_model.dart';

class Separation extends StatefulWidget {
  final Pedido pedido;
  const Separation({
    super.key,
    required this.pedido,
  });

  @override
  State<Separation> createState() => _SeparationState();
}

class _SeparationState extends State<Separation> {
  final observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        MultiLineText(
          label: 'Observações do Separador:',
          controller: observacoesController,
        ),
        const SizedBox(height: 8),
        saveButton(() {}),
      ],
    );
  }
}
