import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';
import 'widgets/detailed_button.dart';
import 'widgets/details.dart';
import 'widgets/groups.dart';

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
  final pesoAcessorioController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeAcessorioController = TextEditingController();
  final volumeChapaController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Groups(groups: widget.pedido.grupos, context: context),
      Details(
        setorSeparacao: setorSeparacaoController,
        pesoAcessorio: pesoAcessorioController,
        volumeAcessorio: volumeAcessorioController,
        volumeAluminio: volumeAluminioController,
        volumeChapas: volumeChapaController,
        observacoesSeparacao: observacoesSeparacaoController,
        observacoesSeparador: observacoesSeparadorController,
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 90, 16),
        child: Material(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: DetailedButton(
                  onTap: () => setState(() => _selectedIndex = 0),
                  icon: Icons.group_work,
                  label: 'Grupos',
                  isActive: _selectedIndex == 0 ? true : false,
                ),
              ),
              Expanded(
                child: DetailedButton(
                  onTap: () => setState(() => _selectedIndex = 1),
                  icon: Icons.edit,
                  label: 'Detalhes',
                  isActive: _selectedIndex == 1 ? true : false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
