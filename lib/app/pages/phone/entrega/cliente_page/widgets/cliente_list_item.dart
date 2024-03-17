import 'package:flutter/material.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_pedidos_page/rotas_pedidos.dart';

class ClienteListItem extends StatelessWidget {
  const ClienteListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 3,
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => const RotasPedidos(
                nomeCliente: 'Nome do Cliente',
              ),
            ),
          ),
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
                    Icons.person_2_rounded,
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
                              'Nome do Cliente',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '10 Pedidos',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Carregamento'),
                            Text('80%'),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: 0.8,
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
