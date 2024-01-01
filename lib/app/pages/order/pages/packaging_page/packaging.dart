import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../data/blocs/embalagem/embalagem_bloc.dart';
import '../../../../data/blocs/embalagem/embalagem_event.dart';
import '../../../../data/blocs/embalagem/embalagem_state.dart';
import '../../../../models/embalagem_model.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/styles/colors_app.dart';
import '../../../../ui/widgets/error_alert.dart';
import 'widgets/packaging_list_item.dart';
import 'widgets/show_packaging_modal.dart';

class Packaging extends StatefulWidget {
  final PedidoModel pedido;
  const Packaging({
    super.key,
    required this.pedido,
  });

  @override
  State<Packaging> createState() => _PackagingState();
}

class _PackagingState extends State<Packaging> {
  late final EmbalagemBloc _embalagemBloc;

  final numeroCaixaController = TextEditingController();
  final quantidadeController = TextEditingController();
  final pesoController = TextEditingController();
  final observacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _embalagemBloc = EmbalagemBloc();
    fetchData();
  }

  fetchData() {
    _embalagemBloc.inputEmbalagem.add(
      GetEmbalagens(
        idPedido: int.parse(
          widget.pedido.id.toString(),
        ),
      ),
    );
  }

  void clear() {
    numeroCaixaController.clear();
    quantidadeController.clear();
    pesoController.clear();
    observacoesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Embalagens'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<EmbalagemState>(
              stream: _embalagemBloc.outputEmbalagem,
              builder: (context, snapshot) {
                if (snapshot.data is EmbalagemLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.waveDots(
                      color: Theme.of(context).indicatorColor,
                      size: 30,
                    ),
                  );
                } else if (snapshot.data is EmbalagemLoadedState) {
                  List embalagens = snapshot.data?.embalagens ?? [];
                  return RefreshIndicator(
                    onRefresh: () async {
                      fetchData();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: embalagens.length,
                      itemBuilder: (context, index) {
                        EmbalagemModel embalagem = embalagens[index];
                        return PackagingListItem(
                          embalagem: embalagem,
                          onTap: () {
                            numeroCaixaController.text =
                                embalagem.idCaixa ?? '';
                            pesoController.text =
                                embalagem.pesoCaixa.toString();
                            quantidadeController.text =
                                embalagem.quantidadeCaixa.toString();
                            observacoesController.text =
                                embalagem.observacoes ?? '';

                            showPackagingModal(
                              context: context,
                              bloc: _embalagemBloc,
                              idPedido: int.parse(
                                widget.pedido.id.toString(),
                              ),
                              numeroCaixaController: numeroCaixaController,
                              quantidadeController: quantidadeController,
                              pesoController: pesoController,
                              observacoesController: observacoesController,
                              id: int.parse(embalagem.id.toString()),
                            );
                          },
                          onDelete: () => _embalagemBloc.inputEmbalagem.add(
                            DeleteEmbalagem(embalagem: embalagem),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return ErrorAlert(
                    message: snapshot.error.toString(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                clear();
                showPackagingModal(
                  context: context,
                  bloc: _embalagemBloc,
                  idPedido: int.parse(
                    widget.pedido.id.toString(),
                  ),
                  numeroCaixaController: numeroCaixaController,
                  quantidadeController: quantidadeController,
                  pesoController: pesoController,
                  observacoesController: observacoesController,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.primaryColor,
                padding: const EdgeInsets.all(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Adicionar'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _embalagemBloc.inputEmbalagem.close();
    super.dispose();
  }
}
