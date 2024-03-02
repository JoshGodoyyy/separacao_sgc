import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../models/pedido_model.dart';

import '../../../../config/menu_state.dart';

class ItemStatus extends StatefulWidget {
  final PedidoModel pedido;
  const ItemStatus({
    super.key,
    required this.pedido,
  });

  @override
  State<ItemStatus> createState() => _ItemStatusState();
}

class _ItemStatusState extends State<ItemStatus> {
  @override
  Widget build(BuildContext context) {
    DateFormat data = DateFormat('dd/MM/yyyy HH:mm');
    final menuEstado = Provider.of<MenuState>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            setState(() {
              menuEstado.setEstado(true);
              FocusScope.of(context).unfocus();
            });
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pedido: ${widget.pedido.id}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Cliente: ${widget.pedido.nomeCliente} ${widget.pedido.cidade}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Entrega: ${data.format(
                    DateTime.parse(
                      widget.pedido.dataEntrega.toString(),
                    ),
                  )}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
