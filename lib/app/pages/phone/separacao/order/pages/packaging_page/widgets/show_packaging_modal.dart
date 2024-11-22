import 'package:flutter/material.dart';
import '../../../../../../../data/blocs/embalagem/embalagem_bloc.dart';
import '../../../../../../../data/blocs/embalagem/embalagem_event.dart';
import '../../../../../../../data/enums/icones.dart';
import '../../../../../../../models/embalagem_model.dart';
import '../../../../../../../ui/widgets/custom_dialog.dart';
import '../../../widgets/item.dart';
import '../../../widgets/save_button.dart';

Future<dynamic> showPackagingModal({
  required BuildContext context,
  required EmbalagemBloc bloc,
  required int idPedido,
  required TextEditingController numeroCaixaController,
  required TextEditingController quantidadeController,
  required TextEditingController pesoController,
  required TextEditingController observacoesController,
  int? id,
}) {
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
            child: SingleChildScrollView(
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
                      'Salvar',
                      Icons.save,
                      () {
                        if (numeroCaixaController.text == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                titulo: 'Sistema SGC',
                                conteudo: const Text(
                                    'Campo "Número Caixa" obrigatório'),
                                tipo: Icones.erro,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          return;
                        }

                        if (quantidadeController.text == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                titulo: 'Sistema SGC',
                                conteudo: const Text(
                                    'Campo "Quantidade" obrigatório'),
                                tipo: Icones.erro,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          return;
                        }

                        if (pesoController.text == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                titulo: 'Sistema SGC',
                                conteudo:
                                    const Text('Campo "Peso" obrigatório'),
                                tipo: Icones.erro,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          return;
                        }

                        var embalagem = EmbalagemModel(
                          id: id ?? 0,
                          idCaixa: numeroCaixaController.text,
                          idPedido: idPedido,
                          pesoCaixa: double.parse(pesoController.text),
                          quantidadeCaixa: int.parse(quantidadeController.text),
                          observacoes: observacoesController.text,
                        );

                        if (id == null) {
                          bloc.inputEmbalagem.add(
                            PostEmbalagem(embalagem: embalagem),
                          );
                        } else {
                          embalagem.id = id;
                          bloc.inputEmbalagem.add(
                            UpdateEmbalagem(embalagem: embalagem),
                          );
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
