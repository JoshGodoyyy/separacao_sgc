import 'package:flutter/material.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/cliente_page/widgets/cliente_list_item.dart';

class Clientes extends StatefulWidget {
  final RoteiroEntregaModel dados;
  const Clientes({super.key, required this.dados});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.dados.nome!),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          ClienteListItem(),
          ClienteListItem(),
          ClienteListItem(),
          ClienteListItem(),
          ClienteListItem(),
          ClienteListItem(),
          ClienteListItem(),
        ],
      ),
    );
  }
}
