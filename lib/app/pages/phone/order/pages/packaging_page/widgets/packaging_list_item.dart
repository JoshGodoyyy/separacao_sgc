import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../models/embalagem_model.dart';

class PackagingListItem extends StatefulWidget {
  final EmbalagemModel embalagem;
  final Function onTap;
  final Function onDelete;

  const PackagingListItem({
    super.key,
    required this.embalagem,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<PackagingListItem> createState() => _PackagingListItemState();
}

class _PackagingListItemState extends State<PackagingListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => widget.onDelete(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Apagar',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            )
          ],
        ),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          elevation: 3,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => widget.onTap(),
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
                        Text('Nº Caixa: ${widget.embalagem.idCaixa}'),
                        Text('Peso: ${widget.embalagem.pesoCaixa}'),
                        Text('Quantidade: ${widget.embalagem.quantidadeCaixa}'),
                      ],
                    ),
                    Text(
                      'Observações: ${widget.embalagem.observacoes}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
