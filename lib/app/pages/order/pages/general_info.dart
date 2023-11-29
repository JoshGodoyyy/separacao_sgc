import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/pedidos.dart';
import 'package:sgc/app/data/tipo_entrega.dart';
import 'package:sgc/app/data/user_dao.dart';
import 'package:sgc/app/data/vendedor_dao.dart';
import '../widgets/item.dart';

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

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  _populateFields() async {
    final pedido = await Pedidos().fetchOrdersByIdOrder(
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
                criadoPorController,
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
        // Id e Nome do Vendedor
        Row(
          children: [
            Flexible(
              flex: 1,
              child: item(
                context,
                'ID Vendedor:',
                idVendedorController,
                true,
              ),
            ),
            Flexible(
              flex: 2,
              child: item(
                context,
                'Vendedor:',
                vendedorController,
                true,
              ),
            )
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
                numeroEnderecoController,
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
          dataHoraEntregueController,
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
