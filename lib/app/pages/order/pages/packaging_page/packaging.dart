import 'package:flutter/material.dart';

import 'package:sgc/app/models/pack.dart';
import 'package:sgc/app/pages/order/pages/packaging_page/widgets/packaging_list_item.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

import 'widgets/show_packaging_modal.dart';
import '../../../../models/order_model.dart';

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

  void clear() {
    numeroCaixaController.clear();
    quantidadeController.clear();
    pesoController.clear();
    observacoesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Embalagens'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () {
                clear();

                showPackagingModal(
                    context,
                    numeroCaixaController,
                    quantidadeController,
                    pesoController,
                    observacoesController, () {
                  final embalagem = Pack(
                    numeroCaixaController.text,
                    int.parse(quantidadeController.text),
                    double.parse(pesoController.text),
                    observacoesController.text,
                  );

                  //widget.pedido.embalagens.add(embalagem);
                  setState(() {});
                  Navigator.pop(context);
                });
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
          Expanded(
            child: ListView(
              children: [
                // for (Pack embalagem in widget.pedido.embalagens)
                // PackagingListItem(
                //   embalagem: embalagem,
                //   onTap: () {
                //     numeroCaixaController.text =
                //         embalagem.numeroCaixa.toString();
                //     quantidadeController.text =
                //         embalagem.quantidade.toString();
                //     pesoController.text = embalagem.peso.toString();
                //     observacoesController.text = embalagem.observacoes;

                // showPackagingModal(
                //   context,
                //   numeroCaixaController,
                //   quantidadeController,
                //   pesoController,
                //   observacoesController,
                //   () {},
                // );
                //  },
                //),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
