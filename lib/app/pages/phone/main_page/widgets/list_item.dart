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

    String nomeSeparador(String? value) {
      if (value == null) {
        return '';
      }
      List<String> nome = value.split(' ');

      if (nome.length >= 2) {
        return '${nome[0]} ${nome[1]}';
      } else {
        return nome[0];
      }
    }

    Color backColor(String value) {
      Color cor;
      switch (value) {
        case 'BAL':
          cor = Colors.red;
          break;
        case 'RET':
          cor = Colors.orange;
          break;
        default:
          cor = Colors.black26;
          break;
      }
      return cor;
    }

    double progressoSeparado() {
      switch (pedido.status) {
        case 'SEPARANDO':
          if (pedido.quantidadeProdutos! == 0) return 1;
          return pedido.produtosSeparados! / pedido.quantidadeProdutos!;
        case 'EMBALAGEM':
          if (pedido.quantidadeProdutos! == 0) return 1;
          return pedido.produtosEmbalados! / pedido.quantidadeProdutos!;
        default:
          if (pedido.quantidadeProdutos! == 0) return 1;
          return pedido.produtosConferidos! / pedido.quantidadeProdutos!;
      }
    }

    // String avancarPedido() {
    //   var config = Provider.of<AppConfig>(context, listen: false);

    //   String result = '';

    //   switch (pedido.status) {
    //     case 'SEPARAR':
    //       result = 'Iniciar Separação';
    //       break;
    //     case 'SEPARANDO':
    //       if (config.embalagem) {
    //         result = 'Liberar para Embalagem';
    //       } else if (config.conferencia) {
    //         result = 'Liberar para Conferência';
    //       } else if (config.faturar) {
    //         result = 'Finalizar Separação';
    //       }
    //       break;
    //     case 'EMBALAGEM':
    //       if (config.conferencia) {
    //         result = 'Liberar para Conferência';
    //       } else if (config.faturar) {
    //         result = 'Finalizar Separação';
    //       }
    //       break;
    //     case 'CONFERENCIA':
    //       result = 'Finalizar Separação';
    //       break;
    //   }

    //   return result;
    // }

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${pedido.id}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Visibility(
                              visible: pedido.separadorIniciar != null,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  nomeSeparador(pedido.separadorIniciar),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Text(
                              '${pedido.nomeCliente}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${pedido.cidade}',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: backColor(pedido.tipoEntrega!),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                pedido.tipoEntrega ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: pedido.status == 'SEPARANDO' ||
                                      pedido.status == 'EMBALAGEM' ||
                                      pedido.status == 'CONFERENCIA'
                                  ? true
                                  : false,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: double.parse(
                                            pedido.quantidadeProdutos
                                                .toString(),
                                          ) ==
                                          double.parse(
                                            pedido.produtosSeparados.toString(),
                                          )
                                      ? Colors.green
                                      : Colors.orange,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  '${(progressoSeparado() * 100).toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: pedido.status == 'SEPARANDO' ||
                                  pedido.status == 'EMBALAGEM' ||
                                  pedido.status == 'CONFERENCIA'
                              ? true
                              : false,
                          child: LinearProgressIndicator(
                            value: progressoSeparado(),
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
