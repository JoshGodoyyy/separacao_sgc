import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_event.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_state.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/cliente_page/widgets/cliente_list_item.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

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

  _concluirCarregamento() async {
    for (var cliente in clientes) {
      if (cliente.pedidosCarregados < cliente.quantidadePedidos) {
        showDialog(
          context: context,
          builder: (context) {
            return const CustomDialog(
              titulo: 'Sistema SGC',
              descricao: 'Ainda existem pedidos não carregados',
              tipo: Icones.alerta,
            );
          },
        );
      } else {
        widget.bloc.inputRoteiroController.add(
          ConcluirCarregamento(
            idRoteiro: int.parse(
              widget.dados.id.toString(),
            ),
          ),
        );

        showDialog(
          context: context,
          builder: (context) {
            return const CustomDialog(
              titulo: 'Sistema SGC',
              descricao: 'Roteiro carregado com sucesso! Liberado para entrega',
              tipo: Icones.sucesso,
            );
          },
        ).then(
          (value) => Navigator.pop(context),
        );
      }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _concluirCarregamento(),
        backgroundColor: Colors.green,
        label: const Text('Concluir'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
