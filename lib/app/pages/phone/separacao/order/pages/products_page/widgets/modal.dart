import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sgc/app/models/produto_model.dart';

import '../../../widgets/multi_line_text.dart';
import '../../../widgets/save_button.dart';
import 'product_image.dart';

Future<dynamic> showModal(
  BuildContext context,
  ProdutoModel produto,
) {
  final observacoesController = TextEditingController();

  String observacoes;

  produto.observacoes == null
      ? observacoes = ''
      : observacoes = produto.observacoes!;

  observacoesController.text = observacoes;

  Uint8List getImagem() {
    return base64Decode(produto.imagem!);
  }

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //* Imagem do Produto
                  Visibility(
                    visible: produto.imagem != '',
                    child: ProductImage(
                      imagem: getImagem(),
                      label: 'Produto:',
                    ),
                  ),
                  //* Observações do Produto
                  MultiLineText(
                    label: 'Observações do Produto:',
                    controller: observacoesController,
                  ),
                  //* Botão Salvar
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: saveButton(
                      'Salvar',
                      Icons.save,
                      () {
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
