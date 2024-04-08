import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/repositories/fornecedor.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/data/repositories/tipo_entrega.dart';
import 'package:sgc/app/data/repositories/vendedor_dao.dart';
import 'package:sgc/app/models/fornecedor_model.dart';
import 'package:sgc/app/models/pedido_model.dart';
import '../../../../../../ui/widgets/item_field.dart';

class GeneralInfo extends StatefulWidget {
  final int idPedido;
  final String status;
  final String usuarioCriador;

  const GeneralInfo({
    super.key,
    required this.idPedido,
    required this.status,
    required this.usuarioCriador,
  });

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  final criadoPorController = TextEditingController();
  final dataCriacaoController = TextEditingController();
  final idClienteController = TextEditingController();
  final razaoSocialController = TextEditingController();
  final idVendedorController = TextEditingController();
  final vendedorController = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroEnderecoController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final cepController = TextEditingController();
  final dataHoraEntregueController = TextEditingController();
  final tipoEntregaController = TextEditingController();
  final nfeVendaController = TextEditingController();
  final nfeRemessaController = TextEditingController();
  String titulo = '';

  @override
  void initState() {
    super.initState();
  }

  bool mostrarNFe() {
    return widget.status == 'OK' ? true : false;
  }

  DateFormat data = DateFormat('dd/MM/yyyy HH:mm');

  _populateFields() async {
    final pedido = await Pedido().fetchOrdersByIdOrder(
      int.parse(
        widget.idPedido.toString(),
      ),
    );

    final String usuarioCriacao = widget.usuarioCriador;

    final vendedor = await VendedorDAO().fetchVendedor(
      int.parse(
        pedido.idVendedor.toString(),
      ),
    );

    final tipoEntrega = await TipoEntregaDAO().fetchTipoEntrega(
      int.parse(
        pedido.idTipoEntrega.toString(),
      ),
    );

    criadoPorController.text = usuarioCriacao;

    dataCriacaoController.text = data.format(
      DateTime.parse(
        pedido.dataCriacao.toString(),
      ),
    );

    idClienteController.text = pedido.idCliente.toString();
    razaoSocialController.text = pedido.razaoSocial.toString();
    idVendedorController.text = pedido.idVendedor.toString();
    vendedorController.text = vendedor.nome.toString();

    dataHoraEntregueController.text = data.format(
      DateTime.parse(
        pedido.dataEntrega.toString(),
      ),
    );

    tipoEntregaController.text = tipoEntrega.descricao.toString();
    nfeVendaController.text = pedido.nnFeVenda.toString();
    nfeRemessaController.text = pedido.nnFeRemessa.toString();

    _verificarEndereco(pedido);
  }

  _verificarEndereco(PedidoModel pedido) async {
    if (pedido.triangulacao == 1) {
      titulo = 'Triangulação';

      int idForn = int.parse(
        pedido.idFornNFe.toString(),
      );

      int idCli = int.parse(
        pedido.idCliNFe.toString(),
      );

      FornecedorModel fornecedor;

      if (idForn > 0) {
        fornecedor = await Fornecedor().fetchFornecedor(idForn);
      } else {
        fornecedor = await Fornecedor().fetchCliente(idCli);
      }

      enderecoController.text =
          '${fornecedor.logradouro} ${fornecedor.nomeRua}';
      numeroEnderecoController.text = fornecedor.numero.toString();
      complementoController.text = fornecedor.complemento.toString();
      bairroController.text = fornecedor.bairro.toString();
      cidadeController.text = fornecedor.cidade.toString();
      estadoController.text = fornecedor.estado.toString();
      cepController.text = fornecedor.cep.toString();
    } else {
      if (pedido.entNomeRua != '') {
        titulo = 'End. Cadastro';
        enderecoController.text =
            '${pedido.entLogradouro} ${pedido.entNomeRua}';
        numeroEnderecoController.text = pedido.entNumero.toString();
        complementoController.text = pedido.entComplemento.toString();
        bairroController.text = pedido.entBairro.toString();
        cidadeController.text = pedido.entCidade.toString();
        estadoController.text = pedido.entEstado.toString();
        cepController.text = pedido.entCEP.toString();
      } else {
        titulo = 'End. Entrega';
        enderecoController.text = '${pedido.logradouro} ${pedido.endereco}';
        numeroEnderecoController.text = pedido.numero.toString();
        complementoController.text = pedido.complemento.toString();
        bairroController.text = pedido.bairro.toString();
        cidadeController.text = pedido.cidade.toString();
        estadoController.text = pedido.estado.toString();
        cepController.text = pedido.cep.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _populateFields(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Criado por:',
                      controller: criadoPorController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Data de Criação:',
                      controller: dataCriacaoController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'ID Cliente:',
                      controller: idClienteController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Razão Social:',
                      controller: razaoSocialController,
                    ),
                  ),
                ],
              ),
              ItemField(
                label: 'Vendedor:',
                controller: vendedorController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).dividerColor,
                        height: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(titulo),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).dividerColor,
                        height: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              ItemField(
                label: 'Endereço:',
                controller: enderecoController,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Número:',
                      controller: numeroEnderecoController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Complemento:',
                      controller: complementoController,
                    ),
                  ),
                ],
              ),
              ItemField(
                label: 'Bairro:',
                controller: bairroController,
              ),
              ItemField(
                label: 'Cidade:',
                controller: cidadeController,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Estado:',
                      controller: estadoController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'CEP:',
                      controller: cepController,
                    ),
                  ),
                ],
              ),
              const Divider(),
              ItemField(
                label: 'Data e Hora de Entrega:',
                controller: dataHoraEntregueController,
              ),
              ItemField(
                label: 'Tipo de Entrega:',
                controller: tipoEntregaController,
              ),
              Visibility(
                visible: mostrarNFe(),
                child: Row(
                  children: [
                    Expanded(
                      child: ItemField(
                        label: 'NFe Venda:',
                        controller: nfeVendaController,
                      ),
                    ),
                    Expanded(
                      child: ItemField(
                        label: 'NFe Remessa:',
                        controller: nfeRemessaController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Criado por:',
                      controller: criadoPorController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Data de Criação:',
                      controller: dataCriacaoController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'ID Cliente:',
                      controller: idClienteController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Razão Social:',
                      controller: razaoSocialController,
                    ),
                  ),
                ],
              ),
              ItemField(
                label: 'Vendedor:',
                controller: vendedorController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).dividerColor,
                        height: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(titulo),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).dividerColor,
                        height: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              ItemField(
                label: 'Endereço:',
                controller: enderecoController,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Número:',
                      controller: numeroEnderecoController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Complemento:',
                      controller: complementoController,
                    ),
                  ),
                ],
              ),
              ItemField(
                label: 'Bairro:',
                controller: bairroController,
              ),
              ItemField(
                label: 'Cidade:',
                controller: cidadeController,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'Estado:',
                      controller: estadoController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'CEP:',
                      controller: cepController,
                    ),
                  ),
                ],
              ),
              const Divider(),
              ItemField(
                label: 'Data e Hora de Entrega:',
                controller: dataHoraEntregueController,
              ),
              ItemField(
                label: 'Tipo de Entrega:',
                controller: tipoEntregaController,
              ),
              Visibility(
                visible: mostrarNFe(),
                child: Row(
                  children: [
                    Expanded(
                      child: ItemField(
                        label: 'NFe Venda:',
                        controller: nfeVendaController,
                      ),
                    ),
                    Expanded(
                      child: ItemField(
                        label: 'NFe Remessa:',
                        controller: nfeRemessaController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
