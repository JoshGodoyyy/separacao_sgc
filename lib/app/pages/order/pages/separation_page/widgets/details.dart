import 'package:flutter/material.dart';
import 'package:sgc/app/models/pedido_model.dart';

import '../../../../../data/repositories/pedidos.dart';
import '../../../widgets/item.dart';
import '../../../widgets/multi_line_text.dart';

class Details extends StatefulWidget {
  final PedidoModel pedido;
  const Details({
    super.key,
    required this.pedido,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final volumeAcessorioController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeChapasController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final pesoAcessorioController = TextEditingController();

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

    volumeAcessorioController.text = pedido.volumeAcessorio.toString();
    volumeAluminioController.text = pedido.volumePerfil.toString();
    volumeChapasController.text = pedido.volumeChapa.toString();
    observacoesSeparacaoController.text =
        pedido.observacoesSeparacao.toString();
    observacoesSeparadorController.text =
        pedido.observacoesSeparador.toString();
    setorSeparacaoController.text = pedido.setorEstoque.toString();
    pesoAcessorioController.text = pedido.pesoAcessorios.toString();
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
                  volumeAcessorioController,
                  false,
                  TextInputType.number,
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Alum.:',
                  volumeAluminioController,
                  false,
                  TextInputType.number,
                ),
              ),
              Flexible(
                flex: 3,
                child: item(
                  context,
                  'Vol. Chapas:',
                  volumeChapasController,
                  false,
                  TextInputType.number,
                ),
              ),
            ],
          ),
          MultiLineText(
            label: 'Observações para Separação:',
            controller: observacoesSeparacaoController,
          ),
          MultiLineText(
            label: 'Observações do Separador:',
            controller: observacoesSeparadorController,
          ),
          item(
            context,
            'Setor de Separação:',
            setorSeparacaoController,
          ),
          item(
            context,
            'Peso Acessório:',
            pesoAcessorioController,
            false,
            TextInputType.number,
          ),
        ],
      ),
    );
  }
}
