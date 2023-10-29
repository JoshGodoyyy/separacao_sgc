import 'package:flutter/material.dart';

import '/app/models/pack.dart';

class PackagingListItem extends StatelessWidget {
  final Pack embalagem;
  final Function onTap;

  const PackagingListItem({
    super.key,
    required this.embalagem,
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
                      Text('Nº Caixa: ${embalagem.numeroCaixa}'),
                      Text('Peso: ${embalagem.peso}'),
                      Text('Quantidade: ${embalagem.quantidade}'),
                    ],
                  ),
                  Text(
                    'Observações: ${embalagem.observacoes}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
