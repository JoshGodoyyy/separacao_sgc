import 'package:flutter/material.dart';

import '../../../models/pedido_model.dart';
import '../widgets/item.dart';

class GeneralInfo extends StatefulWidget {
  final Pedido pedido;
  const GeneralInfo({
    super.key,
    required this.pedido,
  });

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  final dataCriacaoController = TextEditingController();
  final fantasiaController = TextEditingController();
  final idOrcamentoController = TextEditingController();
  final pedidoClienteController = TextEditingController();
  final observacoesController = TextEditingController();
  final tipoEntregaController = TextEditingController();
  final pesoController = TextEditingController();
  final cidadeController = TextEditingController();
  final setorEntregaController = TextEditingController();
  final vendedorController = TextEditingController();
  final financeiroController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var pedido = widget.pedido;

    dataCriacaoController.text = pedido.dataCriacao.toString();
    fantasiaController.text = pedido.cliente.fantasia.toString();
    idOrcamentoController.text = pedido.idPedido.toString();
    tipoEntregaController.text = pedido.tipoEntrega.toString();
    vendedorController.text = pedido.vendedor.nomeVendedor.toString();
    statusController.text = pedido.statusPedido.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        item('Data de criação:', dataCriacaoController, true),
        item('Fantasia:', fantasiaController, true),
        item('Id orçamento:', idOrcamentoController, true),
        item('Pedido cliente:', pedidoClienteController),
        item('Observações:', observacoesController),
        //const Item(label: 'Data de entrega:'),
        item('Tipo de entrega:', tipoEntregaController),
        item('Peso:', pesoController),
        //item('Tratamento:'),
        item('Cidade:', cidadeController),
        item('Setor de entrega:', setorEntregaController),
        item('Vendedor:', vendedorController),
        //const Item(label: 'Data de liberação:'),
        item('Financeiro:', financeiroController),
        //const Item(label: 'Status:'),
      ],
    );
  }
}
