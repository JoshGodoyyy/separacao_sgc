import 'package:flutter/material.dart';

import '../../../models/pedido_model.dart';
import '../widgets/item.dart';
import '/app/enums/sale_types.dart';

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
  final nomeUsuarioController = TextEditingController();
  final statusPedidoController = TextEditingController();
  final idClienteController = TextEditingController();
  final fantasiaController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final dataHoraEntregaController = TextEditingController();
  final tipoEntregaController = TextEditingController();
  final nfeVendaController = TextEditingController();
  final nfeRemessaController = TextEditingController();

  SaleTypes saleType = SaleTypes.faturamento;

  @override
  void initState() {
    super.initState();

    var pedido = widget.pedido;

    dataCriacaoController.text = pedido.dataCriacao.toString();
    nomeUsuarioController.text = pedido.nomeUsuario.toString();
    saleType = SaleTypes.values.firstWhere(
      (element) =>
          element.toString().split('.').last == pedido.tipoVenda.toLowerCase(),
    );
    statusPedidoController.text = pedido.statusPedido.toString();
    idClienteController.text = pedido.cliente.id.toString();
    fantasiaController.text = pedido.cliente.fantasia.toString();
    razaoSocialController.text = pedido.cliente.razaoSocial.toString();
    enderecoController.text = pedido.cliente.endereco.toString();
    numeroController.text = pedido.cliente.numero.toString();
    if (pedido.cliente.complemento == null) {
      complementoController.text = '';
    } else {
      cepController.text = pedido.cliente.cep.toString();
    }
    bairroController.text = pedido.cliente.bairro.toString();
    cidadeController.text = pedido.cliente.cidade.toString();
    estadoController.text = pedido.cliente.uf.toString();
    dataHoraEntregaController.text = pedido.dataHoraEntrega.toString();
    tipoEntregaController.text = pedido.tipoEntrega.toString();
    nfeVendaController.text = pedido.nfeVenda.toString();
    nfeRemessaController.text = pedido.nfeRemessa.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Nome de Usuário e Data de Criação
        Row(
          children: [
            Flexible(
              flex: 1,
              child: item(
                context,
                'Criado por:',
                nomeUsuarioController,
                true,
              ),
            ),
            Flexible(
              flex: 2,
              child: item(
                context,
                'Data de Criação:',
                dataCriacaoController,
                true,
              ),
            ),
          ],
        ),
        // Id Cliente e Razão Social
        Row(
          children: [
            // Id Cliente
            Flexible(
              flex: 1,
              child: item(
                context,
                'ID Cliente:',
                idClienteController,
                true,
              ),
            ),
            Flexible(
              flex: 2,
              child: item(
                context,
                'Razão Social:',
                razaoSocialController,
                true,
              ),
            ),
          ],
        ),
        // Endereço Cliente
        item(
          context,
          'Endereço:',
          enderecoController,
          true,
        ),
        // Numero e Complemento Cliente
        Row(
          children: [
            Flexible(
              flex: 1,
              child: item(
                context,
                'Número:',
                numeroController,
                true,
              ),
            ),
            Flexible(
              flex: 2,
              child: item(
                context,
                'Complemento:',
                complementoController,
                true,
              ),
            ),
          ],
        ),
        // Bairro
        item(
          context,
          'Bairro:',
          bairroController,
          true,
        ),
        // Cidade
        item(
          context,
          'Cidade:',
          cidadeController,
          true,
        ),
        // Estado e CEP Cliente
        Row(
          children: [
            Flexible(
              flex: 1,
              child: item(
                context,
                'Estado:',
                estadoController,
                true,
              ),
            ),
            Flexible(
              flex: 2,
              child: item(
                context,
                'CEP:',
                cepController,
                true,
              ),
            )
          ],
        ),
        // Data e Hora de Entrega
        item(
          context,
          'Data e Hora de Entrega:',
          dataHoraEntregaController,
          true,
        ),
        // Tipo de Entrega
        item(
          context,
          'Tipo de Entrega:',
          tipoEntregaController,
          true,
        ),
        // NFe Venda e NFe Remessa
        Row(
          children: [
            Expanded(
              child: item(
                context,
                'NFe Venda:',
                nfeVendaController,
                true,
              ),
            ),
            Expanded(
              child: item(
                context,
                'NFe Remessa:',
                nfeRemessaController,
                true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
