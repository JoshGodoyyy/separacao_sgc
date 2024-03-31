import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_event.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_state.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/cliente_page/widgets/cliente_list_item.dart';

import '../../../../ui/widgets/error_alert.dart';

class Clientes extends StatefulWidget {
  final RoteiroEntregaModel dados;
  const Clientes({super.key, required this.dados});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  late ClienteBloc _clienteBloc;

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
            List clientes = snapshot.data?.clientes ?? [];
            return ListView(
              children: [
                for (var cliente in clientes)
                  ClienteListItem(
                    cliente: cliente,
                    roteiroEntrega: widget.dados,
                    bloc: _clienteBloc,
                  ),
              ],
            );
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
