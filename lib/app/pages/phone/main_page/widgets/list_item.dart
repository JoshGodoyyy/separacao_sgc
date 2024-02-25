import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/pedido_model.dart';

class ListItem extends StatelessWidget {
  final IconData icon;
  final PedidoModel pedido;
  final Function onClick;
  const ListItem({
    super.key,
    required this.icon,
    required this.pedido,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat data = DateFormat('dd/MM/yyyy HH:mm');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 3,
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
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
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pedido: ${pedido.id}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Cliente: ${pedido.nomeCliente} ${pedido.cidade}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Entrega: ${data.format(
                            DateTime.parse(
                              pedido.dataEntrega.toString(),
                            ),
                          )}',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
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
