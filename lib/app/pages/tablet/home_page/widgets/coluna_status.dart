import 'package:flutter/material.dart';
import 'package:sgc/app/pages/tablet/home_page/widgets/item_status.dart';

class ColunaStatus extends StatefulWidget {
  final String titulo;
  final Color cor;
  const ColunaStatus({
    super.key,
    required this.titulo,
    required this.cor,
  });

  @override
  State<ColunaStatus> createState() => _ColunaStatusState();
}

class _ColunaStatusState extends State<ColunaStatus> {
  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      width: largura / 3,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.cor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              width: largura / 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    widget.titulo,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
                ItemStatus(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          const Text(
            '10 itens',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
