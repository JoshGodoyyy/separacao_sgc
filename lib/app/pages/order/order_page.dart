import 'package:flutter/material.dart';
import 'package:sgc/app/pages/order/pages/general_info.dart';
import 'package:sgc/app/pages/order/pages/observations.dart';
import 'package:sgc/app/pages/order/pages/packaging.dart';
import 'package:sgc/app/pages/order/pages/products.dart';
import 'package:sgc/app/pages/order/pages/separation.dart';

import '../../ui/styles/colors_app.dart';
import '/app/models/pedido_model.dart';

class Order extends StatefulWidget {
  final Pedido pedido;
  const Order({
    super.key,
    required this.pedido,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      GeneralInfo(pedido: widget.pedido),
      Products(pedido: widget.pedido),
      Separation(pedido: widget.pedido),
      Packaging(pedido: widget.pedido),
      Observations(pedido: widget.pedido),
    ];

    final List<String> titles = [
      'Dados Gerais',
      'Produtos',
      'Separação/Grupos',
      'Embalagens',
      'Observações Separador',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.elementColor,
        title: Text(
          titles[currentPage],
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
              ),
              title: const Text('Dados Gerais'),
              onTap: () {
                Navigator.pop(context);
                setState(() => currentPage = 0);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.amp_stories_rounded,
              ),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.pop(context);
                setState(() => currentPage = 1);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.group_work_rounded,
              ),
              title: const Text('Separação/Grupos'),
              onTap: () {
                Navigator.pop(context);
                setState(() => currentPage = 2);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.archive,
              ),
              title: const Text('Embalagens'),
              onTap: () {
                Navigator.pop(context);
                setState(() => currentPage = 3);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.app_registration_outlined,
              ),
              title: const Text('Observações Separador'),
              onTap: () {
                Navigator.pop(context);
                setState(() => currentPage = 4);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(),
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_back,
              ),
              title: const Text('Voltar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: screens[currentPage],
    );
  }
}
