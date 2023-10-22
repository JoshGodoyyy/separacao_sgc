import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/widgets/save_button.dart';
import 'package:sgc/app/pages/order/widgets/search_text.dart';

import '../../../models/pedido_model.dart';
import '../../../ui/styles/colors_app.dart';
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
  final tipoController = TextEditingController();
  final pedidoController = TextEditingController();
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

    tipoController.text = pedido.tipo.toString();
    pedidoController.text = pedido.idPedido.toString();
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

  String formatType(SaleTypes type) {
    String obj = type.toString().split('.').last;

    if (obj == SaleTypes.venda.toString().split('.').last) {
      return 'Venda';
    } else if (obj == SaleTypes.faturamento.toString().split('.').last) {
      return 'Faturamento';
    } else if (obj == SaleTypes.remessa.toString().split('.').last) {
      return 'Remessa';
    } else if (obj == SaleTypes.amostra.toString().split('.').last) {
      return 'Amostra';
    } else if (obj == SaleTypes.troca.toString().split('.').last) {
      return 'Troca';
    } else if (obj == SaleTypes.futuraCompra.toString().split('.').last) {
      return 'Futura Compra';
    } else if (obj == SaleTypes.empresa.toString().split('.').last) {
      return 'Empresa';
    } else if (obj == SaleTypes.ncfe.toString().split('.').last) {
      return 'NCF-e';
    } else {
      return 'NC-e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Tipo
        item(
          'Tipo',
          tipoController,
          true,
        ),
        // Tipo de Venda
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Tipo de Venda',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: const BoxDecoration(
                  color: ColorsApp.elementColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: DropdownMenu<SaleTypes>(
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  width: MediaQuery.of(context).size.width - 32,
                  initialSelection: saleType,
                  onSelected: (value) => setState(() => saleType = value!),
                  dropdownMenuEntries: SaleTypes.values.map(
                    (tipo) {
                      return DropdownMenuEntry(
                        value: tipo,
                        label: formatType(tipo),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
        // Número do Pedido
        item(
          'Pedido:',
          pedidoController,
          true,
        ),
        // Data de Criação
        item(
          'Data de Criação:',
          dataCriacaoController,
          true,
        ),
        // Nome de Usuário de Criação
        item(
          'Criado por:',
          nomeUsuarioController,
          true,
        ),
        // Status do Pedido
        item(
          'Status Pedido:',
          statusPedidoController,
          true,
        ),
        // Id Cliente
        SearchText(
          label: 'ID Cliente:',
          controller: idClienteController,
          onTap: () {},
        ),
        // Fantasia Cliente
        item(
          'Fantasia:',
          fantasiaController,
          true,
        ),
        // Razão Social Cliente
        item(
          'Razão Social:',
          razaoSocialController,
          true,
        ),
        // CEP Cliente
        item(
          'CEP:',
          cepController,
          true,
        ),
        // Endereço Cliente
        item(
          'Endereço:',
          enderecoController,
          true,
        ),
        // Numero e Complemento Cliente
        Row(
          children: [
            Expanded(
              child: item(
                'Número:',
                numeroController,
                true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: item(
                'Complemento:',
                complementoController,
                true,
              ),
            ),
          ],
        ),
        // Bairro
        item(
          'Bairro:',
          bairroController,
          true,
        ),
        // Cidade
        item(
          'Cidade:',
          cidadeController,
          true,
        ),
        // Estado
        item(
          'Estado:',
          estadoController,
          true,
        ),
        // Data e Hora de Entrega
        item(
          'Data e Hora de Entrega:',
          dataHoraEntregaController,
          true,
        ),
        // Tipo de Entrega
        item(
          'Tipo de Entrega:',
          tipoEntregaController,
          true,
        ),
        // NFe Venda
        item(
          'NFe Venda:',
          nfeVendaController,
          true,
        ),
        // NFe Remessa
        item(
          'NFe Remessa:',
          nfeRemessaController,
          true,
        ),
        const SizedBox(height: 8),
        saveButton(() {}),
      ],
    );
  }
}
