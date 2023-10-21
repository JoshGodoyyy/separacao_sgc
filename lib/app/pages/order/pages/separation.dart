import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
