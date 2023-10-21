import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
