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
      Color cor;
      switch (tipo) {
        case Icones.alerta:
          cor = Colors.yellow[700]!;
          break;
        case Icones.erro:
          cor = Colors.red;
          break;
        case Icones.info:
          cor = Colors.blue;
          break;
        case Icones.filtro:
        case Icones.pergunta:
          cor = Colors.deepPurple[700]!;
          break;
        case Icones.sucesso:
          cor = Colors.green;
          break;
      }
      return cor;
    }

    Icon icone() {
      switch (tipo) {
        case Icones.alerta:
          return const Icon(
            Icons.assignment_late_rounded,
            color: Colors.white,
            size: 100,
          );
        case Icones.erro:
          return const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
            size: 125,
          );
        case Icones.info:
          return const Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
            size: 125,
          );
        case Icones.sucesso:
          return const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
            size: 100,
          );
        case Icones.filtro:
          return const Icon(
            Icons.filter_list_alt,
            color: Colors.white,
            size: 100,
          );
        case Icones.pergunta:
          return const Icon(
            Icons.question_mark_rounded,
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
