import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sgc/app/data/blocs/produto/produto_bloc.dart';
import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/models/colors.dart';

import '../../../../../models/produto_model.dart';
import 'item_color.dart';

class ProdutoListItem extends StatelessWidget {
  final ProdutoModel produto;
  final ProdutoBloc bloc;
  final int tipoProduto;
  final int idPedido;

  final Function onTap;
  const ProdutoListItem({
    super.key,
    required this.produto,
    required this.bloc,
    required this.onTap,
    required this.tipoProduto,
    required this.idPedido,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                bloc.inputProdutoController.add(
                  UpdateProduto(
                    idProduto: int.parse(
                      produto.id.toString(),
                    ),
                    separado: 1,
                    tipoProduto: tipoProduto,
                    idPedido: idPedido,
                  ),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Separado',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            )
          ],
        ),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => onTap(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          produto.idProduto.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ItemColor(
                          cor: Cor(
                            'Vermelho',
                            Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${produto.quantidade} ${produto.idUnidade}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      produto.descricao.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Peso Unit.: ${produto.peso}',
                        ),
                        Text(
                          'Peso Tot.: ${produto.pesoTotal}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
