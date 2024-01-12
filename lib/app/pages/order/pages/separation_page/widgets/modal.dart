import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_event.dart';
import '../../../../../data/blocs/grupo/grupo_bloc.dart';
import '../../../../../models/group_model.dart';

Future<dynamic> showModal(
  BuildContext context,
  GrupoBloc bloc,
  GrupoModel item,
  int idPedido,
  int tipoProduto,
) async {
  final pesoController = TextEditingController();
  bool separado = item.separado! == 1 ? true : false;

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
                      const Text(
                        'Peso real',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextField(
                        controller: pesoController,
                        onChanged: (value) {
                          if (pesoController.text.isEmpty) return;

                          if (int.parse(value) > 0) {
                            setState(() => separado = true);
                          } else {
                            setState(() => separado = false);
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: separado,
                            onChanged: (value) {
                              setState(() => separado = value!);
                            },
                          ),
                          const Text('Separado')
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
                                var grupo = GrupoModel(
                                  id: item.id,
                                  idGrupo: item.idGrupo,
                                  descricao: item.descricao,
                                  pesoReal: double.parse(pesoController.text),
                                  separado: separado ? 1 : 0,
                                  difal: item.difal,
                                  juros: item.juros,
                                  pesoTeorico: item.pesoTeorico,
                                  valorGrupo: item.valorGrupo,
                                  valorReal: item.valorReal,
                                );

                                bloc.inputGrupo.add(
                                  UpdateGrupo(
                                    grupo: grupo,
                                    idPedido: idPedido,
                                    tipoProduto: tipoProduto,
                                  ),
                                );
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
