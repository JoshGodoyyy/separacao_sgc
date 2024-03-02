import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../../../config/menu_state.dart';

class PedidoInfo extends StatefulWidget {
  const PedidoInfo({
    super.key,
  });

  @override
  State<PedidoInfo> createState() => _PedidoInfoState();
}

class _PedidoInfoState extends State<PedidoInfo> {
  @override
  Widget build(BuildContext context) {
    final menuEstado = Provider.of<MenuState>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(-5, 0),
              ),
            ],
          ),
          width: menuEstado.aberto ? MediaQuery.of(context).size.width / 2 : 0,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: () => setState(
                                      () => menuEstado.setEstado(false),
                                    ),
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      'Pedido 1234',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Detalhes'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Produtos',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Separação'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, right: 24),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SpeedDial(
                      icon: Icons.menu,
                      iconTheme: const IconThemeData(color: Colors.white),
                      overlayOpacity: 0.6,
                      children: [
                        //* Finalizar Separação
                        SpeedDialChild(
                          child: const Icon(Icons.shopping_cart_outlined),
                          label: 'Finalizar Separação',
                          onTap: () async {},
                        ),
                        //* Liberar para Conferência
                        SpeedDialChild(
                          child: const Icon(Icons.checklist_rtl_rounded),
                          label: 'Liberar para Conferência',
                          onTap: () async {},
                        ),
                        //* Liberar para Embalagem
                        SpeedDialChild(
                          child: const Icon(Icons.archive),
                          label: 'Liberar para Embalagem',
                          onTap: () async {},
                        ),
                        //* Iniciar Separação
                        SpeedDialChild(
                          child: const Icon(Icons.directions_walk_outlined),
                          label: 'Iniciar Separação',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'SGC',
                                  ),
                                  content: const Text(
                                    'Deseja iniciar separação?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {},
                                      child: const Text(
                                        'Sim',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Não',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        //* Embalagem
                        SpeedDialChild(
                            child: const Icon(Icons.inbox),
                            label: 'Embalagens',
                            onTap: () {}),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
