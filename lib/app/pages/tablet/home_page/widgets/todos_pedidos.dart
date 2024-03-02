import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';

import 'coluna_status.dart';

class TodosPedidos extends StatelessWidget {
  const TodosPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<AppConfig>(context);

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Visibility(
              visible: config.separar,
              child: const ColunaStatus(
                titulo: 'Separar',
                cor: Colors.red,
                idStatus: 2,
              ),
            ),
            Visibility(
              visible: config.separando,
              child: const ColunaStatus(
                titulo: 'Separando',
                cor: Colors.orange,
                idStatus: 3,
              ),
            ),
            Visibility(
              visible: config.embalagem,
              child: const ColunaStatus(
                titulo: 'Embalagem',
                cor: Color(0xff6482b4),
                idStatus: 14,
              ),
            ),
            Visibility(
              visible: config.conferencia,
              child: const ColunaStatus(
                titulo: 'Conferência',
                cor: Color(0xffa300d3),
                idStatus: 15,
              ),
            ),
            Visibility(
              visible: config.faturar,
              child: const ColunaStatus(
                titulo: 'Faturar',
                cor: Color(0xff348000),
                idStatus: 5,
              ),
            ),
            Visibility(
              visible: config.logistica,
              child: const ColunaStatus(
                titulo: 'Logística',
                cor: Color(0xFFFFC400),
                idStatus: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
