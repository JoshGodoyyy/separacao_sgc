import 'package:flutter/material.dart';

import '/app/pages/order/widgets/save_button.dart';
import '../../../ui/styles/colors_app.dart';
import 'multi_line_text.dart';
import 'search_text.dart';

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
                SearchText(
                  label: 'Tratamento:',
                  controller: searchController,
                  onTap: () {},
                ),
                MultiLineText(
                  label: 'Observações do Produto:',
                  controller: observacoesController,
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
