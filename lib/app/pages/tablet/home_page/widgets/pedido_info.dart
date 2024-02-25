import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            menuEstado.setEstado(false);
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Titulo',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
