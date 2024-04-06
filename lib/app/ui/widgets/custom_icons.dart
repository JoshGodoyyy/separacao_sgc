import 'package:flutter/material.dart';
import 'package:sgc/app/data/enums/icones.dart';

class CustomIcon extends StatelessWidget {
  final Icones tipo;
  const CustomIcon({
    super.key,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    Color cor() {
      if (tipo == Icones.alerta) {
        return Colors.yellow;
      } else if (tipo == Icones.erro) {
        return Colors.red;
      } else if (tipo == Icones.info) {
        return Colors.blue;
      } else {
        return Colors.green;
      }
    }

    Icon icone() {
      if (tipo == Icones.alerta) {
        return const Icon(
          Icons.assignment_late_rounded,
          color: Colors.white,
          size: 100,
        );
      } else if (tipo == Icones.erro) {
        return const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 125,
        );
      } else if (tipo == Icones.info) {
        return const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 125,
        );
      } else {
        return const Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
          size: 100,
        );
      }
    }

    return CircleAvatar(
      backgroundColor: cor(),
      radius: 66,
      child: Center(
        child: icone(),
      ),
    );
  }
}
