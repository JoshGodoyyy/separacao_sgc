import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/worker_function.dart';

import '../../../../models/product.dart';
import '/app/models/pedido_model.dart';
import 'widgets/accessories.dart';
import 'widgets/all_items.dart';
import 'widgets/modal.dart';
import 'widgets/product_list_item.dart';

class Products extends StatelessWidget {
  final Pedido pedido;
  const Products({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    final workerFunction = Provider.of<WorkerFunction>(context);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (Product produto in pedido.produtos)
          ProductListItem(
            product: produto,
            onTap: () => showModal(context),
          ),
      ],
    );
  }
}
