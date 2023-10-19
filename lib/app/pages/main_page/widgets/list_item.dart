import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/order_page.dart';

import '/app/models/pedido_model.dart';
import '/app/ui/styles/colors_app.dart';

class ListItem extends StatelessWidget {
  final Pedido pedido;
  const ListItem({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 3,
        color: ColorsApp.elementColor,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => Order(
                pedido: pedido,
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
                  Icon(
                    pedido.icone,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pedido: ${pedido.idPedido}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Cliente: ${pedido.cliente.fantasia}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Entrega: ${pedido.dataHoraEntrega}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
