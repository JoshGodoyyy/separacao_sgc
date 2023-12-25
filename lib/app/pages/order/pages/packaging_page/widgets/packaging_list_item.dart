import 'package:flutter/material.dart';

import '../../../../../models/embalagem_model.dart';

class PackagingListItem extends StatelessWidget {
  final EmbalagemModel embalagem;
  final Function onTap;

  const PackagingListItem({
    super.key,
    required this.embalagem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      Text('Nº Caixa: ${embalagem.idCaixa}'),
                      Text('Peso: ${embalagem.pesoCaixa}'),
                      Text('Quantidade: ${embalagem.quantidadeCaixa}'),
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
