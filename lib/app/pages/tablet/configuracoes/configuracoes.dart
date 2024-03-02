import 'package:flutter/material.dart';
import 'package:sgc/app/pages/tablet/configuracoes/telas/separacao.dart';

class TConfiguracoes extends StatefulWidget {
  const TConfiguracoes({super.key});

  @override
  State<TConfiguracoes> createState() => _TConfiguracoesState();
}

class _TConfiguracoesState extends State<TConfiguracoes> {
  final int _index = 0;

  final List<Widget> _telas = const [
    ConfiguracoesSeparacao(),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            _telas[_index],
          ],
        ),
      ),
    );
  }
}
