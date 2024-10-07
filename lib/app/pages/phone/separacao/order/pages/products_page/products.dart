import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/blocs/produto/produto_bloc.dart';
import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/data/blocs/produto/produto_state.dart';
import 'package:sgc/app/data/repositories/tratamento.dart';
import 'package:sgc/app/ui/widgets/list_header.dart';
import '../../../../../../data/repositories/pedido.dart';
import '../../../../../../models/pedido_model.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import 'widgets/modal.dart';
import 'widgets/produto_list_item.dart';

class Products extends StatefulWidget {
  final PedidoModel pedido;
  final int tipoProduto;
  final bool tratamentoEspecial;

  const Products({
    super.key,
    required this.pedido,
    required this.tipoProduto,
    required this.tratamentoEspecial,
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
    final pedido = await Pedido().fetchOrdersByIdOrder(
      int.parse(
        widget.pedido.id.toString(),
      ),
    );

    tratamento = pedido.tratamento!;

    final tratamentoInicial = await Tratamento().fetchTratamentoById(
      tratamento,
    );

    tratamentoController.text = tratamentoInicial.descricao.toString();
  }

  Widget listaProdutos(List produtos) {
    produtos.sort((a, b) {
      if (a.setorEstoque != null) {
        return a.setorEstoque!.compareTo(b.setorEstoque!);
      } else {
        return a.idProduto!.compareTo(b.idProduto);
      }
    });

    switch (widget.pedido.status) {
      case 'SEPARANDO':
        return Column(
          children: [
            ListHeader(
              label: 'Produtos não Separados',
              count:
                  '${produtos.where((element) => element.separado == false).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.separado == false) item(produto),
            ListHeader(
              label: 'Produtos Separados',
              count:
                  '${produtos.where((element) => element.separado == true).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.separado!) item(produto)
          ],
        );
      case 'EMBALAGEM':
        return Column(
          children: [
            ListHeader(
              label: 'Produtos não Embalados',
              count:
                  '${produtos.where((element) => element.embalado == false).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.embalado == false) item(produto),
            ListHeader(
              label: 'Produtos Embalados',
              count:
                  '${produtos.where((element) => element.separado == true).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.embalado!) item(produto)
          ],
        );
      case 'CONFERENCIA':
        return Column(
          children: [
            ListHeader(
              label: 'Produtos não Conferidos',
              count:
                  '${produtos.where((element) => element.conferido == false).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.conferido == false) item(produto),
            ListHeader(
              label: 'Produtos Conferidos',
              count:
                  '${produtos.where((element) => element.conferido == true).toList().length}',
            ),
            for (var produto in produtos)
              if (produto.conferido!) item(produto)
          ],
        );
      default:
        return Column(
          children: [
            for (var produto in produtos) item(produto),
          ],
        );
    }
  }

  Widget item(dynamic produto) {
    return ProdutoListItem(
      status: widget.pedido.status!,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Visibility(
          visible: widget.tratamentoEspecial,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
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
                      listaProdutos(produtos),
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
