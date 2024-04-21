import 'package:flutter/material.dart';

class ConsultarEstoque extends StatefulWidget {
  const ConsultarEstoque({super.key});

  @override
  State<ConsultarEstoque> createState() => _ConsultarEstoqueState();
}

class _ConsultarEstoqueState extends State<ConsultarEstoque> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  child: LinearProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
