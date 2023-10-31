import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/worker_function.dart';

import '../../../../models/product.dart';
import '/app/models/pedido_model.dart';
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

    List<Product> filteredList() {
      List<Product> items = [];
      if (workerFunction.accessories && workerFunction.profiles) {
        items = pedido.produtos;
      } else {
        if (workerFunction.accessories) {
          items = pedido.produtos
              .where((item) => item.tipo.toLowerCase() == 'acessório')
              .toList();
        } else if (workerFunction.profiles) {
          items = pedido.produtos
              .where((item) => item.tipo.toLowerCase() == 'perfil')
              .toList();
        } else {
          items = [];
        }
      }

      return items;
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (Product produto in filteredList())
          ProductListItem(
            product: produto,
            onTap: () => showModal(context),
          ),
      ],
    );
  }
}
