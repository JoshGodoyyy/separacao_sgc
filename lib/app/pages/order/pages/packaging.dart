import 'package:flutter/material.dart';
import 'package:sgc/app/models/pack.dart';
import 'package:sgc/app/pages/order/widgets/item.dart';
import 'package:sgc/app/pages/order/widgets/packaging_list_item.dart';
import 'package:sgc/app/pages/order/widgets/save_button.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

import '/app/models/pedido_model.dart';

class Packaging extends StatefulWidget {
  final Pedido pedido;
  const Packaging({
    super.key,
    required this.pedido,
  });

  @override
  State<Packaging> createState() => _PackagingState();
}

class _PackagingState extends State<Packaging> {
  final numeroCaixaController = TextEditingController();
  final quantidadeController = TextEditingController();
  final pesoController = TextEditingController();
  final observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Adicionar
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: ColorsApp.backgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  item(
                                    'Número Caixa:',
                                    numeroCaixaController,
                                  ),
                                  item(
                                    'Quantidade:',
                                    quantidadeController,
                                    false,
                                    TextInputType.number,
                                  ),
                                  item(
                                    'Peso:',
                                    pesoController,
                                    false,
                                    TextInputType.number,
                                  ),
                                  item(
                                    'Observações:',
                                    observacoesController,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: saveButton(
                                      () {
                                        final embalagem = Pack(
                                          numeroCaixaController.text,
                                          int.parse(quantidadeController.text),
                                          double.parse(pesoController.text),
                                          observacoesController.text,
                                        );

                                        widget.pedido.embalagens.add(embalagem);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primaryColor,
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('Adicionar'),
                    ],
                  ),
                ),
              ),
              // Salvar
              Expanded(
                child: saveButton(
                  () {},
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (Pack embalagem in widget.pedido.embalagens)
                PackagingListItem(
                  embalagem: embalagem,
                  onTap: () {},
                ),
            ],
          ),
        ),
      ],
    );
  }
}
