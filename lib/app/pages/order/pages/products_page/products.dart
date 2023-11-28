import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';

import '../../../../models/product.dart';
import '../../../../models/order_model.dart';
import 'widgets/modal.dart';
import 'widgets/product_list_item.dart';

class Products extends StatefulWidget {
  final Pedido pedido;
  const Products({
    super.key,
    required this.pedido,
  });

  @override
  State<Products> createState() => _ProductsState();
}

const List<String> list = <String>[
  'ACESSÓRIO',
  'BRANCO BRILHANTE',
  'CEREJEIRA',
  'CINZA',
  'ESPECIAL',
];

class _ProductsState extends State<Products> {
  String dropValue = list.first;

  @override
  Widget build(BuildContext context) {
    final workerFunction = Provider.of<AppConfig>(context);

    List<Product> filteredList() {
      List<Product> items = [];
      // if (workerFunction.accessories && workerFunction.profiles) {
      //   items = widget.pedido.produtos;
      // } else {
      //   if (workerFunction.accessories) {
      //     items = widget.pedido.produtos
      //         .where((item) => item.tipo.toLowerCase() == 'acessório')
      //         .toList();
      //   } else if (workerFunction.profiles) {
      //     items = widget.pedido.produtos
      //         .where((item) => item.tipo.toLowerCase() == 'perfil')
      //         .toList();
      //   } else {
      //     items = [];
      //   }
      // }

      return items;
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Trat. quando utilizado Grupo Especial:',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Material(
                elevation: 5,
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: DropdownMenu<String>(
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  width: MediaQuery.of(context).size.width - 32,
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() => dropValue = value!);
                  },
                  dropdownMenuEntries: list.map((String value) {
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              for (Product produto in filteredList())
                ProductListItem(
                  product: produto,
                  onTap: () => showModal(
                    context,
                    produto,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
