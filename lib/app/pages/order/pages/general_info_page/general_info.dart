import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/data/tipo_entrega.dart';
import 'package:sgc/app/data/user_dao.dart';
import 'package:sgc/app/data/vendedor_dao.dart';
import 'package:sgc/app/pages/order/pages/general_info_page/loading_data.dart';
import 'widgets/item_field.dart';

class GeneralInfo extends StatefulWidget {
  final int idPedido;
  const GeneralInfo({
    super.key,
    required this.idPedido,
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

  DateFormat data = DateFormat('dd/MM/yyyy HH:mm');

  _populateFields() async {
    final pedido = await Pedido().fetchOrdersByIdOrder(
      int.parse(
        widget.idPedido.toString(),
      ),
    );

    final usuarioCriacao = await UserDAO().fetchUser(
      int.parse(
        pedido.idCriador.toString(),
      ),
    );

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

    criadoPorController.text = usuarioCriacao.user.toString();

    dataCriacaoController.text = data.format(
      DateTime.parse(
        pedido.dataCriacao.toString(),
      ),
    );

    idClienteController.text = pedido.idCliente.toString();
    razaoSocialController.text = pedido.razaoSocial.toString();
    idVendedorController.text = pedido.idVendedor.toString();
    vendedorController.text = vendedor.nome.toString();
    enderecoController.text = '${pedido.logradouro} ${pedido.endereco}';
    numeroEnderecoController.text = pedido.numero.toString();
    complementoController.text = pedido.complemento.toString();
    bairroController.text = pedido.bairro.toString();
    cidadeController.text = pedido.cidade.toString();
    estadoController.text = pedido.estado.toString();
    cepController.text = pedido.cep.toString();

    dataHoraEntregueController.text = data.format(
      DateTime.parse(
        pedido.dataEntrega.toString(),
      ),
    );

    tipoEntregaController.text = tipoEntrega.descricao.toString();
    nfeVendaController.text = pedido.nnFeVenda.toString();
    nfeRemessaController.text = pedido.nnFeRemessa.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _populateFields(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingData();
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
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ItemField(
                      label: 'ID Vendedor:',
                      controller: idVendedorController,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ItemField(
                      label: 'Vendedor:',
                      controller: vendedorController,
                    ),
                  ),
                ],
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
              ItemField(
                label: 'Data e Hora de Entrega:',
                controller: dataHoraEntregueController,
              ),
              ItemField(
                label: 'Tipo de Entrega:',
                controller: tipoEntregaController,
              ),
              Row(
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
            ],
          );
        }
      },
    );
  }
}
