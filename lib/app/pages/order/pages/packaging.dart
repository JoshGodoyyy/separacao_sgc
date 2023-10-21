import 'package:flutter/material.dart';

import '/app/models/pedido_model.dart';

class Packaging extends StatefulWidget {
  final Pedido pedido;
  const Packaging({
    super.key,
    required this.pedido,
  });

  @override
  State<Packaging> createState() => _PackagingState();
}

class _PackagingState extends State<Packaging> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
