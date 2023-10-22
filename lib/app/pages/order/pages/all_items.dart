import 'package:flutter/material.dart';

import '../../../pages/order/widgets/modal.dart';
import '../../../models/product.dart';
import '../../../models/pedido_model.dart';
import '../widgets/product_list_item.dart';

ListView allItems(BuildContext context, Pedido pedido) {
  return ListView(
    padding: const EdgeInsets.only(
      top: 12,
    ),
    children: [
      for (Product produto in pedido.produtos)
        ProductListItem(
          product: produto,
          onTap: () => showModal(context),
        ),
    ],
  );
}
