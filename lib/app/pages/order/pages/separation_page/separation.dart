import 'package:flutter/material.dart';

import '../../../../ui/styles/colors_app.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Separação/Grupos',
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorsApp.primaryColor,
            tabs: [
              Tab(
                text: 'Grupos',
              ),
              Tab(
                text: 'Separação',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
