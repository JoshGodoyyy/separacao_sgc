import 'package:flutter/material.dart';
import 'package:sgc/app/models/pedido_model.dart';

import '../../../../../data/repositories/pedido.dart';
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
    final pedido = await Pedido().fetchOrdersByIdOrder(
      int.parse(
        widget.pedido.id.toString(),
      ),
    );

    widget.volumeAcessorio.text = pedido.volumeAcessorio.toString();
    widget.volumeAluminio.text = pedido.volumePerfil.toString();
    widget.volumeChapa.text = pedido.volumeChapa.toString();
    widget.observacoesSeparacao.text = pedido.observacoesSeparacao.toString();
    widget.observacoesSeparador.text = pedido.observacoesSeparador.toString();
    widget.setorSeparacao.text = pedido.setorEstoque.toString();
    widget.pesoAcessorio.text = pedido.pesoAcessorios.toString();
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
          ),
        ],
      ),
    );
  }
}
