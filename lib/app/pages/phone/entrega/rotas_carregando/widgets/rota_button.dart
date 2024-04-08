import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../config/app_config.dart';
import '../../../../../ui/widgets/gradient_icon.dart';

class RotaButton extends StatelessWidget {
  final RoteiroEntregaModel dados;
  final IconData icon;
  final Widget page;
  final Color begin;
  final Color end;
  final RoteiroBloc bloc;

  final BorderRadius border = const BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(20),
  );

  const RotaButton({
    super.key,
    required this.dados,
    required this.icon,
    required this.page,
    required this.begin,
    required this.end,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppConfig>(context);

    double percent(num amount, num total) {
      if (total == 0) {
        return 0;
      } else {
        return amount / total;
      }
    }

    DateFormat data = DateFormat('dd/MM/yyyy');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: begin,
          borderRadius: border,
        ),
        child: Material(
          elevation: 5,
          borderRadius: border,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (builder) => page),
                )
                .then(
                  (value) => bloc.inputRoteiroController.add(
                    GetRoteiros(),
                  ),
                ),
            borderRadius: border,
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
                                  data.format(
                                    DateTime.parse(dados.dataEntrega!),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  dados.nomeMotorista ?? '',
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
                                  '${dados.peso?.toStringAsFixed(2) ?? 0.00} Kg',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                // Text(
                                //   'R\$ ${dados.valor!.toStringAsFixed(2)}',
                                // ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Carregamento'),
                            Text(
                              '${(percent(
                                    dados.quantidadePedidosCarregados!,
                                    dados.quantidadePedidos!,
                                  ) * 100).toStringAsFixed(0)} %',
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: percent(
                            dados.quantidadePedidosCarregados!,
                            dados.quantidadePedidos!,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: Colors.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  '${dados.quantidadeClientes} Clientes',
                                  style: TextStyle(
                                    color: config.isDarkMode
                                        ? Colors.white70
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: Color(0xFF4951A2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  '${dados.quantidadePedidos} Pedidos',
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
}
