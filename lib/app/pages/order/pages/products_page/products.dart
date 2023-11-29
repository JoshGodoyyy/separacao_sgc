import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/pages/order/pages/treatment.dart';

import '../../../../models/product.dart';
import '../../../../models/order_model.dart';

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
    final tratamentoController = TextEditingController();

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trat. quando utilizado Grupo Especial:',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Treatment(),
                ),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: TextField(
                controller: tratamentoController,
                enabled: false,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_forward_ios_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
