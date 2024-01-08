import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sgc/app/models/colors.dart';

import '../../../../../models/product_model.dart';
import 'item_color.dart';

class ProductListItem extends StatelessWidget {
  final ProductModel product;
  final Function onTap;
  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
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
                          product.idProduto.toString(),
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
                      '${product.quantidade} ${product.idUnidade}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.descricao.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Peso Unit.: ${product.peso}',
                        ),
                        Text(
                          'Peso Tot.: ${product.pesoTotal}',
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
