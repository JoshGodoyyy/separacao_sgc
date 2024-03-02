import 'package:flutter/material.dart';

class ItemConfiguracao extends StatelessWidget {
  final String titulo;
  final Function onTap;
  final bool selecionado;

  const ItemConfiguracao({
    super.key,
    required this.titulo,
    required this.onTap,
    required this.selecionado,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Material(
        elevation: 5,
        color: selecionado
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(titulo),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
