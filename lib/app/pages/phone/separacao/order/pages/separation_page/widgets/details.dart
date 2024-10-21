import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgc/app/models/pedido_model.dart';
import '../../../widgets/item.dart';
import '../../../widgets/multi_line_text.dart';

class Details extends StatefulWidget {
  final PedidoModel pedido;
  final TextEditingController volumeAcessorio;
  final TextEditingController volumeAluminio;
  final TextEditingController volumeChapa;
  final TextEditingController observacoesSeparacao;
  final TextEditingController observacoesSeparador;
  final TextEditingController setorSeparacao;
  final TextEditingController pesoAcessorio;

  const Details({
    super.key,
    required this.pedido,
    required this.volumeAcessorio,
    required this.volumeAluminio,
    required this.volumeChapa,
    required this.observacoesSeparacao,
    required this.observacoesSeparador,
    required this.setorSeparacao,
    required this.pesoAcessorio,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    widget.volumeAcessorio.text = widget.pedido.volumeAcessorio.toString();
    widget.volumeAluminio.text = widget.pedido.volumePerfil.toString();
    widget.volumeChapa.text = widget.pedido.volumeChapa.toString();
    widget.observacoesSeparacao.text = widget.pedido.observacoesSeparacao ?? '';
    widget.observacoesSeparador.text = widget.pedido.observacoesSeparador ?? '';
    widget.setorSeparacao.text = widget.pedido.setorEstoque ?? '';
    widget.pesoAcessorio.text = widget.pedido.pesoAcessorios.toString();
  }

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
                  widget.volumeAcessorio,
                  false,
                  TextInputType.number,
                  [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'[0-9]',
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Alum.:',
                  widget.volumeAluminio,
                  false,
                  TextInputType.number,
                  [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Chapas:',
                  widget.volumeChapa,
                  false,
                  TextInputType.number,
                  [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MultiLineText(
            label: 'Observações para Separação:',
            controller: widget.observacoesSeparacao,
          ),
          MultiLineText(
            label: 'Observações do Separador:',
            controller: widget.observacoesSeparador,
          ),
          item(
            context,
            'Setor de Separação:',
            widget.setorSeparacao,
          ),
          item(
            context,
            'Peso Acessório:',
            widget.pesoAcessorio,
            false,
            TextInputType.number,
            [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9]'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
