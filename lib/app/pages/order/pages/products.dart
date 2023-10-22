import 'package:flutter/material.dart';

import '../../../ui/styles/colors_app.dart';
import '/app/models/pedido_model.dart';
import 'accessories.dart';
import 'all_items.dart';
import 'profiles.dart';

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
          backgroundColor: ColorsApp.elementColor,
          title: const Text(
            'Produtos',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
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
