import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/theme_provider.dart';
import '../../ui/styles/colors_app.dart';
import '/app/pages/order/pages/observations.dart';
import 'pages/general_info.dart';
import 'pages/packaging_page/packaging.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';
import '/app/models/pedido_model.dart';

class OrderPage extends StatefulWidget {
  final Pedido pedido;
  const OrderPage({
    super.key,
    required this.pedido,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int currentPage = 0;

  final codigoVendedorController = TextEditingController();

  void clear() {
    codigoVendedorController.clear();
  }

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

    final themeProvider = Provider.of<ThemeProvider>(context);

    String drawerLogo() {
      return themeProvider.currentTheme == ThemeMode.dark
          ? 'assets/images/logo_light.png'
          : 'assets/images/logo.png';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          titles[currentPage],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset(drawerLogo()),
              ),
            ),
            // Dados Gerais
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
            // Produtos
            ListTile(
              leading: const Icon(
                Icons.amp_stories_rounded,
              ),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => Products(pedido: widget.pedido),
                  ),
                );
              },
            ),
            // Separação/Grupos
            ListTile(
              leading: const Icon(
                Icons.group_work_rounded,
              ),
              title: const Text('Separação/Grupos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => Separation(pedido: widget.pedido),
                  ),
                );
              },
            ),
            // Embalagens
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
            // Observações Separador
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
            // Voltar
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
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        iconTheme: const IconThemeData(color: Colors.white),
        overlayOpacity: 0,
        backgroundColor: ColorsApp.primaryColor,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.directions_walk_outlined),
            label: 'Separação',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Código do Vendedor:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: codigoVendedorController,
                          obscureText: true,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (codigoVendedorController.text != '1234') {
                            showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.error(
                                message: 'Senha inválida',
                              ),
                            );
                            clear();
                            return;
                          } else {
                            clear();
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          clear();
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.archive),
            label: 'Embalagens',
          ),
          SpeedDialChild(
            child: const Icon(Icons.checklist_rtl_rounded),
            label: 'Conferência',
          ),
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            label: 'Finalização',
          ),
        ],
      ),
    );
  }
}
