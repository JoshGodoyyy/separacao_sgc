import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_event.dart';
import 'package:sgc/app/models/client_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_pedidos_page/rotas_pedidos.dart';

class ClienteListItem extends StatelessWidget {
  final ClienteModel cliente;
  final RoteiroEntregaModel roteiroEntrega;
  final ClienteBloc bloc;

  const ClienteListItem({
    super.key,
    required this.cliente,
    required this.roteiroEntrega,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    String quantidade(num quantidade) {
      if (quantidade == 1) {
        return '$quantidade Pedido';
      } else {
        return '$quantidade Pedidos';
      }
    }

    double percent() {
      if (cliente.quantidadePedidos == 0) {
        return 0;
      } else {
        return cliente.pedidosCarregados! / cliente.quantidadePedidos!;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 3,
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (builder) => RotasPedidos(
                    roteiroEntrega: roteiroEntrega,
                    cliente: cliente,
                  ),
                ),
              )
              .then(
                (value) => bloc.inputClienteController.add(
                  GetClientes(
                    idRoteiroEntrega: int.parse(
                      roteiroEntrega.id.toString(),
                    ),
                  ),
                ),
              ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_2_rounded,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              cliente.fantasia!,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Text(
                              cliente.razaoSocial!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          quantidade(cliente.quantidadePedidos!),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Carregamento'),
                            Text('${(percent() * 100).toStringAsFixed(0)} %'),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: percent(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
