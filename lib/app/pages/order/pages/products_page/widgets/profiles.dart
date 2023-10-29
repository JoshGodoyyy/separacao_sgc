import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import '../../../../../models/pedido_model.dart';
import 'modal.dart';
import 'product_list_item.dart';

ListView profiles(BuildContext context, Pedido pedido) {
  return ListView(
    padding: const EdgeInsets.only(
      top: 12,
    ),
    children: [
      for (Product produto in pedido.produtos)
        if (produto.tipo.toLowerCase() == 'perfil')
          ProductListItem(
            product: produto,
            onTap: () => showModal(context),
          ),
    ],
  );
}
