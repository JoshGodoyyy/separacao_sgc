import 'package:flutter/material.dart';
import 'package:sgc/app/data/repositories/pedido_roteiro.dart';

Future<void> showModal(
  BuildContext context,
  int idPedido,
  int quantidadeVolumes,
) async {
  final quantidadeVolumesController = TextEditingController();
  quantidadeVolumesController.text = quantidadeVolumes.toString();

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Total de Volumes Carregados',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextField(
                        controller: quantidadeVolumesController,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() {});
                              int total =
                                  int.parse(quantidadeVolumesController.text);
                              await PedidoRoteiro()
                                  .alterarQuantidadePedidosCarregados(
                                idPedido,
                                total,
                              );

                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}
