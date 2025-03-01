import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/cliente_page/pages/ordem_entrega.dart';

import '../../../../../../data/blocs/roteiro_entrega/roteiro_event.dart';
import '../../../../../../data/enums/icones.dart';
import '../../../../../../ui/styles/colors_app.dart';
import '../../../../../../ui/widgets/custom_dialog.dart';
import '../widgets/cliente_list_item.dart';

class ClientesPage extends StatefulWidget {
  final RoteiroEntregaModel dados;
  final RoteiroBloc roteiroBloc;
  final ClienteBloc clienteBloc;
  final List clientes;

  const ClientesPage({
    super.key,
    required this.clientes,
    required this.dados,
    required this.roteiroBloc,
    required this.clienteBloc,
  });

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  _concluirCarregamento() async {
    int pedidosCarregados = 0;
    int quantidadePedidos = 0;

    for (var cliente in widget.clientes) {
      pedidosCarregados += int.parse(
        cliente.pedidosCarregados.toString(),
      );
      quantidadePedidos += int.parse(
        cliente.quantidadePedidos.toString(),
      );
    }

    if (pedidosCarregados < quantidadePedidos) {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomDialog(
            titulo: 'Sistema SGC',
            descricao: 'Ainda existem pedidos não carregados',
            tipo: Icones.alerta,
          );
        },
      ).then(
        (value) => Navigator.pop(context),
      );
    } else {
      widget.roteiroBloc.inputRoteiroController.add(
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
      )
          .then(
            (value) => Navigator.pop(context),
          )
          .then(
            (value) => Navigator.pop(context),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var cliente in widget.clientes)
            ClienteListItem(
              cliente: cliente,
              roteiroEntrega: widget.dados,
              bloc: widget.clienteBloc,
            ),
        ],
      ),
      floatingActionButton: SpeedDial(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        icon: Icons.menu,
        iconTheme: const IconThemeData(color: Colors.white),
        overlayOpacity: 0.6,
        backgroundColor: ColorsApp.primaryColor,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.check),
            label: 'Concluir',
            backgroundColor: Colors.green,
            labelBackgroundColor: Colors.green,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Sistema SGC'),
                    content:
                        const Text('Deseja mesmo concluir o carregamento?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => _concluirCarregamento(),
                        child: const Text('Sim'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.filter_list),
            label: 'Reordenar',
            backgroundColor: Colors.orange,
            labelBackgroundColor: Colors.orange,
            onTap: () {
              int pedidosCarregados = 0;
              for (var cliente in widget.clientes) {
                pedidosCarregados += int.parse(
                  cliente.pedidosCarregados.toString(),
                );
              }

              if (pedidosCarregados > 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomDialog(
                      titulo: 'Sistema SGC',
                      descricao:
                          'Não é possível reordenar a rota, já existem pedidos carregados',
                      tipo: Icones.erro,
                    );
                  },
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrdemEntrega(
                      dados: widget.dados,
                      pedidosNaoOrdenados: false,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
