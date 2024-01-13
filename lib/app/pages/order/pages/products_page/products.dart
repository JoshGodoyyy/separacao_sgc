import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/blocs/produto/produto_bloc.dart';
import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/data/blocs/produto/produto_state.dart';
import 'package:sgc/app/data/tratamento.dart';
import 'package:sgc/app/pages/order/pages/products_page/widgets/modal.dart';
import 'package:sgc/app/pages/order/pages/products_page/widgets/produto_list_item.dart';
import 'package:sgc/app/ui/widgets/list_header.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/widgets/error_alert.dart';

class Products extends StatefulWidget {
  final PedidoModel pedido;
  final int tipoProduto;

  const Products({
    super.key,
    required this.pedido,
    required this.tipoProduto,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late String tratamento;
  late ProdutoBloc _produtoBloc;
  final tratamentoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _produtoBloc = ProdutoBloc();
    _fetchProdutos();
    _fetchTratamento();
  }

  _fetchProdutos() {
    _produtoBloc.inputProdutoController.add(
      GetProdutos(
        tipoProduto: widget.tipoProduto,
        idPedido: int.parse(
          widget.pedido.id.toString(),
        ),
      ),
    );
  }

  _fetchTratamento() async {
    if (widget.pedido.tratamento == null || widget.pedido.tratamento == '') {
      tratamento = '';
    } else {
      tratamento = widget.pedido.tratamento!;

      final tratamentoInicial = await Tratamento().fetchTratamentoById(
        tratamento,
      );

      tratamentoController.text = tratamentoInicial.descricao.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            'Trat. quando utilizado Grupo Especial:',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: TextField(
              controller: tratamentoController,
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<ProdutoState>(
            stream: _produtoBloc.outputProdutoController,
            builder: (context, snapshot) {
              if (snapshot.data is ProdutoLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: Theme.of(context).indicatorColor,
                    size: 30,
                  ),
                );
              } else if (snapshot.data is ProdutoLoadedState) {
                List produtos = snapshot.data?.produtos ?? [];
                return RefreshIndicator(
                  onRefresh: () async {
                    _fetchTratamento();
                    _fetchProdutos();
                  },
                  child: ListView(
                    children: [
                      const ListHeader(label: 'Produtos não Separados'),
                      for (var produto in produtos)
                        if (produto.separado == false)
                          ProdutoListItem(
                            produto: produto,
                            bloc: _produtoBloc,
                            onTap: () => showModal(
                              context,
                              produto,
                            ),
                            tipoProduto: widget.tipoProduto,
                            idPedido: int.parse(
                              widget.pedido.id.toString(),
                            ),
                          ),
                      const ListHeader(label: 'Produtos Separados'),
                      for (var produto in produtos)
                        if (produto.separado)
                          ProdutoListItem(
                            produto: produto,
                            bloc: _produtoBloc,
                            onTap: () => showModal(
                              context,
                              produto,
                            ),
                            tipoProduto: widget.tipoProduto,
                            idPedido: int.parse(
                              widget.pedido.id.toString(),
                            ),
                          ),
                    ],
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
      ],
    );
  }
}
