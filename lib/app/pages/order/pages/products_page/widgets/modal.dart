import 'package:flutter/material.dart';
import 'package:sgc/app/models/product.dart';
import 'package:sgc/app/pages/order/pages/products_page/widgets/item_color.dart';

import '/app/pages/order/widgets/save_button.dart';
import '../../../widgets/multi_line_text.dart';
import 'item_detail.dart';
import 'product_image.dart';

Future<dynamic> showModal(
  BuildContext context,
  Product produto,
) {
  final observacoesController = TextEditingController();

  String observacoes;

  produto.observacoes == null
      ? observacoes = ''
      : observacoes = produto.observacoes!;

  observacoesController.text = observacoes;

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MultiLineText(
                  label: 'Observações do Produto:',
                  controller: observacoesController,
                ),
                ItemDetail(
                  label: 'Cor',
                  child: Row(
                    children: [
                      ItemColor(
                        cor: produto.cor,
                      ),
                      const SizedBox(width: 10),
                      Text(produto.cor.nomeCor),
                    ],
                  ),
                ),
                const ProductImage(
                  label: 'Produto:',
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: saveButton(
                    () {
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
}
