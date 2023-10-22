import 'package:flutter/material.dart';

import '../../../ui/styles/colors_app.dart';
import '../../../models/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final Function onTap;
  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 3,
        color: ColorsApp.elementColor,
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
                  Text(
                    'Código: ${product.codigo}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Descrição: ${product.descricao}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Text('Unidade: ${product.unidade}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Qtd.: ${product.quantidade}'),
                      Text('Peso Unit..: ${product.pesoUnit}'),
                      Text(
                        'Peso Tot.: ${product.quantidade * product.pesoUnit}',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
