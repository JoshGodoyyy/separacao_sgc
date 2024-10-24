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
      return cliente.pedidosCarregados! / cliente.quantidadePedidos!;
    }

    String quantidadePedidos(ClienteModel cliente) {
      return quantidade(cliente.quantidadePedidos!);
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
                    pedidosAgrupados: agrupamentoPedidos,
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
                        Visibility(
                          visible: cliente.tratamentoItens == 'ESP',
                          child: Text('ESP.: ${cliente.tratamentoEspecial}'),
                        ),
                        Visibility(
                          visible: cliente.tratamentoItens != '' &&
                              cliente.tratamentoItens != null,
                          child: Wrap(
                            children: [
                              Text(
                                cliente.tratamentoItens ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              '[${cliente.idCliente}] ${cliente.fantasia}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Text(
                              cliente.enderecoCompleto(),
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
                        const SizedBox(height: 8),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'Peso Total: ${cliente.pesoTotal} Kg',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Visibility(
                              visible:
                                  cliente.volumeAcessorio == 0 ? false : true,
                              child: volumeContainer(
                                'Acessórios: ${cliente.volumeAcessorio}',
                              ),
                            ),
                            Visibility(
                              visible:
                                  cliente.volumeAcessorio == 0 ? false : true,
                              child: const SizedBox(width: 8),
                            ),
                            Visibility(
                              visible: cliente.volumeChapa == 0 ? false : true,
                              child: volumeContainer(
                                'Chapas: ${cliente.volumeChapa}',
                              ),
                            ),
                            Visibility(
                              visible: cliente.volumeChapa == 0 ? false : true,
                              child: const SizedBox(width: 8),
                            ),
                            Visibility(
                              visible: cliente.volumePerfil == 0 ? false : true,
                              child: volumeContainer(
                                'Perfis: ${cliente.volumePerfil}',
                              ),
                            ),
                          ],
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

  Container volumeContainer(String label) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
