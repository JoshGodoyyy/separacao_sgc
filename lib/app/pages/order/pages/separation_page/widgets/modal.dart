import 'package:flutter/material.dart';

import '../../../../../models/group_model.dart';

Future<dynamic> showModal(BuildContext context, GroupModel item) async {
  final pesoController = TextEditingController();
  bool separar = item.separar;

  pesoController.text = item.pesoReal.toString();

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
                      const Text('Peso real:'),
                      TextField(
                        controller: pesoController,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: separar,
                              onChanged: (value) {
                                setState(() => separar = value!);
                              }),
                          const Text('Separar')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                item.pesoReal =
                                    double.parse(pesoController.text);
                                item.separar = separar;
                                Navigator.pop(context);
                              },
                              child: const Text('Salvar'),
                            ),
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
