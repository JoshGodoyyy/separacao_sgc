import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PedidoListItem extends StatefulWidget {
  const PedidoListItem({super.key});

  @override
  State<PedidoListItem> createState() => _PedidoListItemState();
}

class _PedidoListItemState extends State<PedidoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Carregado',
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
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                'ID do Pedido',
                                style: TextStyle(
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
