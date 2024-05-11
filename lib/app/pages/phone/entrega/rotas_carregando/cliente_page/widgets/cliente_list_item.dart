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
  final bool agrupamentoPedidos;

  const ClienteListItem({
    super.key,
    required this.cliente,
    required this.roteiroEntrega,
    required this.bloc,
    required this.agrupamentoPedidos,
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
      if (agrupamentoPedidos) {
        if (cliente.pedidosAgrupados! > 0) {
          if (cliente.quantidadePedidos == 0) {
            return 0;
          } else {
            return cliente.pedidosCarregados! / cliente.pedidosAgrupados!;
          }
        } else {
          if (cliente.quantidadePedidos == 0) {
            return 0;
          } else {
            return cliente.pedidosCarregados! / cliente.quantidadePedidos!;
          }
        }
      } else {
        if (cliente.quantidadePedidos == 0) {
          return 0;
        } else {
          return cliente.pedidosCarregados! / cliente.quantidadePedidos!;
        }
      }
    }

    String quantidadePedidos(ClienteModel cliente) {
      if (agrupamentoPedidos) {
        if (int.parse(cliente.pedidosAgrupados.toString()) > 0) {
          return quantidade(cliente.pedidosAgrupados!);
        } else {
          return quantidade(cliente.quantidadePedidos!);
        }
      } else {
        return quantidade(cliente.quantidadePedidos!);
      }
    }

    String endereco(ClienteModel cliente) {
      String value;
      if (cliente.complemento!.isEmpty) {
        value =
            '${cliente.logradouro} ${cliente.endereco}, ${cliente.numero} - ${cliente.bairro} - ${cliente.cidade} - ${cliente.estado}. ${cliente.cep}';
      } else {
        value =
            '${cliente.logradouro} ${cliente.endereco}, ${cliente.numero} ${cliente.complemento} - ${cliente.bairro} - ${cliente.cidade} - ${cliente.estado}. ${cliente.cep}';
      }
      return value;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 5,
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
                      pedidosAgrupados: agrupamentoPedidos),
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
                              endereco(cliente),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          quantidadePedidos(cliente),
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
