import 'package:flutter/material.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_finalizadas/dados_entrega/pages/dados.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_finalizadas/dados_entrega/pages/rotas.dart';

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
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.roteiro.nome ?? ''),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            tabs: [
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
