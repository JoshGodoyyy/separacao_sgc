import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '/app/pages/order/widgets/save_button.dart';
import '../../../widgets/multi_line_text.dart';
import '../../../widgets/search_text.dart';
import 'product_image.dart';

Future<dynamic> showModal(BuildContext context) {
  final searchController = TextEditingController();
  final observacoesController = TextEditingController();

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
                SearchText(
                  label: 'Tratamento:',
                  controller: searchController,
                  onTap: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                        message: 'Feature em desenvolvimento!',
                      ),
                    );
                  },
                ),
                MultiLineText(
                  label: 'Observações do Produto:',
                  controller: observacoesController,
                ),
                const ProductImage(
                  label: 'Imagem:',
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: saveButton(
                    () => Navigator.pop(context),
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
