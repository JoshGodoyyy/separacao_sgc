import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/models/pedido_roteiro_model.dart';

import '../../../../../../../data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';

class PedidoListItem extends StatefulWidget {
  final PedidoRoteiroModel pedido;
  final PedidoRoteiroBloc bloc;

  const PedidoListItem({
    super.key,
    required this.pedido,
    required this.bloc,
  });

  @override
  State<PedidoListItem> createState() => _PedidoListItemState();
}

class _PedidoListItemState extends State<PedidoListItem> {
  String label() {
    String result;
    widget.pedido.carregado == 1
        ? result = 'Não Carregado'
        : result = 'Carregado';
    return result;
  }

  void update() {
    if (widget.pedido.carregado == 1) {
      widget.bloc.inputProdutoRoteiroController.add(
        DescarregarPedido(pedido: widget.pedido),
      );
    } else {
      widget.bloc.inputProdutoRoteiroController.add(
        CarregarPedido(pedido: widget.pedido),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                update();
              },
              backgroundColor:
                  widget.pedido.carregado == 1 ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
              icon: widget.pedido.carregado == 1 ? Icons.close : Icons.check,
              label: label(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            )
          ],
        ),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          elevation: 3,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {},
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
                      Icons.add_shopping_cart_outlined,
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
                                'Pedido ${widget.pedido.id}',
                                style: const TextStyle(
                                  fontSize: 15,
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
      ),
    );
  }
}
