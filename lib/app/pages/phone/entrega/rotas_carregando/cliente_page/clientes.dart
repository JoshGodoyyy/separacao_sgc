import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_event.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_state.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/cliente_page/pages/clientes_page.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/cliente_page/pages/ordem_entrega.dart';

import '../../../../../ui/widgets/error_alert.dart';

class Clientes extends StatefulWidget {
  final RoteiroEntregaModel dados;
  final RoteiroBloc bloc;
  const Clientes({
    super.key,
    required this.dados,
    required this.bloc,
  });

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  late ClienteBloc _clienteBloc;
  late List clientes;

  @override
  void initState() {
    super.initState();
    _clienteBloc = ClienteBloc();
    _fetchClientes();
  }

  _fetchClientes() {
    _clienteBloc.inputClienteController.add(
      GetClientes(
        idRoteiroEntrega: int.parse(
          widget.dados.id.toString(),
        ),
      ),
    );
  }

  Widget _mostrarDados(List clientes) {
    int quantidadeEnderecoNaoOrdenado = 0;

    for (var cliente in clientes) {
      if (cliente.posicao == 0) {
        quantidadeEnderecoNaoOrdenado++;
      }
    }

    if (quantidadeEnderecoNaoOrdenado > 1) {
      return OrdemEntrega(
        dados: widget.dados,
      );
    } else {
      return ClientesPage(
        clientes: clientes,
        dados: widget.dados,
        roteiroBloc: widget.bloc,
        clienteBloc: _clienteBloc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.dados.nome!),
        centerTitle: true,
      ),
      body: StreamBuilder<ClienteState>(
        stream: _clienteBloc.outputClienteController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data is ClienteLoadingState) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: LinearProgressIndicator(),
              ),
            );
          } else if (snapshot.data is ClienteLoadedState) {
            clientes = snapshot.data?.clientes ?? [];

            return _mostrarDados(clientes);
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
    );
  }
}
