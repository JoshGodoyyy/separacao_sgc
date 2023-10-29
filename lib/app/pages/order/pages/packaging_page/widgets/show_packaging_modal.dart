import 'package:flutter/material.dart';

import '../../../widgets/item.dart';
import '../../../widgets/save_button.dart';

Future<dynamic> showPackagingModal(
  BuildContext context,
  TextEditingController numeroCaixaController,
  TextEditingController quantidadeController,
  TextEditingController pesoController,
  TextEditingController observacoesController,
  Function onTap,
) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
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
                item(
                  context,
                  'Número Caixa:',
                  numeroCaixaController,
                ),
                item(
                  context,
                  'Quantidade:',
                  quantidadeController,
                  false,
                  TextInputType.number,
                ),
                item(
                  context,
                  'Peso:',
                  pesoController,
                  false,
                  TextInputType.number,
                ),
                item(
                  context,
                  'Observações:',
                  observacoesController,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: saveButton(
                    () => onTap(),
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
