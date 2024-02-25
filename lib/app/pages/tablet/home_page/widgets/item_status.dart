import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/menu_state.dart';

class ItemStatus extends StatefulWidget {
  const ItemStatus({super.key});

  @override
  State<ItemStatus> createState() => _ItemStatusState();
}

class _ItemStatusState extends State<ItemStatus> {
  @override
  Widget build(BuildContext context) {
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Titulo',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Pedido',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Cliente',
                  style: TextStyle(
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
