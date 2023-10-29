import 'package:flutter/material.dart';

import '../../../../ui/styles/colors_app.dart';
import '/app/models/pedido_model.dart';
import 'widgets/accessories.dart';
import 'widgets/all_items.dart';
import 'widgets/profiles.dart';

class Products extends StatefulWidget {
  final Pedido pedido;
  const Products({
    super.key,
    required this.pedido,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Produtos',
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorsApp.primaryColor,
            tabs: [
              Tab(
                text: 'Acessórios',
              ),
              Tab(
                text: 'Perfis',
              ),
              Tab(
                text: 'Todos',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            accessories(
              context,
              widget.pedido,
            ),
            profiles(
              context,
              widget.pedido,
            ),
            allItems(
              context,
              widget.pedido,
            )
          ],
        ),
      ),
    );
  }
}
