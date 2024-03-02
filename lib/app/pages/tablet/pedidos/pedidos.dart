import 'package:flutter/material.dart';

class TPedidos extends StatefulWidget {
  final int idStatus;
  const TPedidos({
    super.key,
    required this.idStatus,
  });

  @override
  State<TPedidos> createState() => _TPedidosState();
}

class _TPedidosState extends State<TPedidos> {
  String titulo() {
    String result;
    switch (widget.idStatus) {
      case 2:
        result = 'Separar';
        break;
      case 3:
        result = 'Separando';
        break;
      case 5:
        result = 'Faturar';
        break;
      case 10:
        result = 'Logística';
        break;
      case 14:
        result = 'Embalagem';
        break;
      default:
        result = 'Conferência';
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              titulo(),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
