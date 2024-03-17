import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../config/app_config.dart';
import '../../../../../ui/widgets/gradient_icon.dart';

class RotaButton extends StatelessWidget {
  final RoteiroEntregaModel dados;
  final IconData icon;
  final Widget page;
  final Color begin;
  final Color end;
  final Function refresh;

  const RotaButton({
    super.key,
    required this.dados,
    required this.icon,
    required this.page,
    required this.begin,
    required this.end,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppConfig>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: begin,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(20),
          ),
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (builder) => page),
                )
                .then((value) => refresh()),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GradientIcon(
                              icon: icon,
                              size: 54,
                              gradient: LinearGradient(
                                colors: [
                                  begin,
                                  end,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: 100,
                              width: 0.5,
                              color: Theme.of(context).dividerColor,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dados.nome ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  dados.dataEntrega ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  dados.motorista ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  dados.placa ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${dados.peso} Kg',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'R\$ ${dados.valorTotal!.toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Carregamento'),
                            Text('50%'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const LinearProgressIndicator(
                          value: .5,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Color(0xFF4951A2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              child: Text(
                                '${dados.totalClientes} Clientes',
                                style: TextStyle(
                                  color: config.isDarkMode
                                      ? Colors.white70
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: Color(0xFF4951A2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              child: Text(
                                '${dados.totalPedidos} Pedidos',
                                style: TextStyle(
                                  color: config.isDarkMode
                                      ? Colors.white70
                                      : Colors.white,
                                ),
                              ),
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
      ),
    );
  }
}
