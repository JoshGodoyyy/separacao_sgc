import 'package:flutter/material.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'pages/dados.dart';
import 'pages/galeria.dart';
import 'pages/rotas.dart';

class DadosEntrega extends StatefulWidget {
  final RoteiroEntregaModel roteiro;
  const DadosEntrega({
    super.key,
    required this.roteiro,
  });

  @override
  State<DadosEntrega> createState() => _DadosEntregaState();
}

class _DadosEntregaState extends State<DadosEntrega> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.roteiro.nome ?? ''),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Galeria',
              ),
              Tab(
                text: 'Detalhes',
              ),
              Tab(
                text: 'Rotas',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Galeria(
              roteiro: widget.roteiro,
            ),
            Dados(
              roteiro: widget.roteiro,
            ),
            Rotas(
              roteiro: widget.roteiro,
            ),
          ],
        ),
      ),
    );
  }
}
