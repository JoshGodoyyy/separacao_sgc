import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import 'pages/dados.dart';
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
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.roteiro.nome ?? ''),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                showModal(context);
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: 'Concluir',
                    child: Text('Concluir Roteiro'),
                  ),
                ];
              },
            )
          ],
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

  TextField text(
      TextEditingController controller, String label, String prefix) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        label: Text(label),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        prefix: Text(prefix),
      ),
    );
  }

  Future<dynamic> showModal(BuildContext context) {
    final pedagioController = TextEditingController();
    final combustivelController = TextEditingController();
    final refeicaoController = TextEditingController();
    final kmFinalController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                text(
                  pedagioController,
                  'Pedágio',
                  'R\$ ',
                ),
                const SizedBox(height: 16),
                text(
                  combustivelController,
                  'Combustível',
                  'R\$ ',
                ),
                const SizedBox(height: 16),
                text(
                  refeicaoController,
                  'Refeição',
                  'R\$ ',
                ),
                const SizedBox(height: 16),
                text(
                  kmFinalController,
                  'Km Final',
                  'Km ',
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (pedagioController.text == '') {
                      pedagioController.text = '0.0';
                    }

                    if (combustivelController.text == '') {
                      combustivelController.text = '0.0';
                    }

                    if (refeicaoController.text == '') {
                      refeicaoController.text = '0.0';
                    }

                    if (kmFinalController.text == '') {
                      kmFinalController.text = '0.0';
                    }

                    RoteiroBloc().inputRoteiroController.add(
                          FinishDados(
                            idRoteiro: int.parse(
                              widget.roteiro.id.toString(),
                            ),
                            pedagio: double.parse(pedagioController.text),
                            combustivel:
                                double.parse(combustivelController.text),
                            refeicao: double.parse(refeicaoController.text),
                            kmFinal: double.parse(kmFinalController.text),
                          ),
                        );

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Concluir'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
