import 'package:flutter/material.dart';

class CDrawerButton extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Function onTap;
  final bool selecionado;

  const CDrawerButton({
    super.key,
    required this.icone,
    required this.titulo,
    required this.onTap,
    required this.selecionado,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icone,
              color: selecionado ? Colors.blueAccent : null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  titulo,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selecionado ? Colors.blueAccent : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
