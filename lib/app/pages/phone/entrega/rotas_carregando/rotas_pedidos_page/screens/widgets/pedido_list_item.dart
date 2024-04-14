import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/models/pedido_roteiro_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_pedidos_page/screens/produtos_pedido.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

import '../../../../../../../config/app_config.dart';
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
    final settings = Provider.of<AppConfig>(context, listen: false);
    if (widget.pedido.idStatus! <= 5 && widget.pedido.carregado == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomDialog(
            titulo: 'Atenção',
            descricao: 'O pedido deve estar liberado para poder ser carregado',
            tipo: Icones.alerta,
          );
        },
      );
    } else {
      if (widget.pedido.carregado == 1) {
        widget.bloc.inputProdutoRoteiroController.add(
          DescarregarPedido(
            pedido: widget.pedido,
            separarAgrupamento: settings.separarAgrupamento,
          ),
        );
      } else {
        widget.bloc.inputProdutoRoteiroController.add(
          CarregarPedido(
            pedido: widget.pedido,
            separarAgrupamento: settings.separarAgrupamento,
          ),
        );
      }
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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProdutosPedido(
                  idPedido: int.parse(
                    widget.pedido.id.toString(),
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Pedido ${widget.pedido.id}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Setor Estoque: ${widget.pedido.setorEstoque ?? ''}',
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text('${widget.pedido.status}'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            height: 0.5,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Volumes'),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        volumeContainer(
                            'Acessórios: ${widget.pedido.volumeAcessorio}'),
                        const SizedBox(width: 8),
                        volumeContainer('Chapas: ${widget.pedido.volumeChapa}'),
                        const SizedBox(width: 8),
                        volumeContainer(
                            'Perfis: ${widget.pedido.volumePerfil}'),
                      ],
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
      ),
    );
  }
}
