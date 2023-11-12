import 'package:flutter/material.dart';

import '../../../widgets/item.dart';
import '../../../widgets/multi_line_text.dart';

class Details extends StatelessWidget {
  final TextEditingController setorSeparacao;
  final TextEditingController pesoAcessorio;
  final TextEditingController volumeAcessorio;
  final TextEditingController volumeAluminio;
  final TextEditingController volumeChapas;
  final TextEditingController observacoesSeparacao;
  final TextEditingController observacoesSeparador;

  const Details({
    super.key,
    required this.setorSeparacao,
    required this.pesoAcessorio,
    required this.volumeAcessorio,
    required this.volumeAluminio,
    required this.volumeChapas,
    required this.observacoesSeparacao,
    required this.observacoesSeparador,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Aces.:',
                  volumeAcessorio,
                  false,
                  TextInputType.number,
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Alum.:',
                  volumeAluminio,
                  false,
                  TextInputType.number,
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Chapas:',
                  volumeChapas,
                  false,
                  TextInputType.number,
                ),
              ),
            ],
          ),
          MultiLineText(
            label: 'Observações para Separação:',
            controller: observacoesSeparacao,
          ),
          MultiLineText(
            label: 'Observações do Separador:',
            controller: observacoesSeparador,
          ),
          item(
            context,
            'Setor de Separação:',
            setorSeparacao,
          ),
          item(
            context,
            'Peso Acessório:',
            pesoAcessorio,
            false,
            TextInputType.number,
          ),
        ],
      ),
    );
  }
}
