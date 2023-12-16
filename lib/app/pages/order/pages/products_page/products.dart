import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/produtos.dart';
import 'package:sgc/app/data/tratamento.dart';
import 'package:sgc/app/pages/order/pages/products_page/widgets/modal.dart';
import 'package:sgc/app/pages/order/pages/products_page/widgets/product_list_item.dart';

import '../../../../data/pedidos.dart';
import '../../../../models/order_model.dart';
import '../treatment.dart';

class Products extends StatefulWidget {
  final Pedido pedido;
  const Products({
    super.key,
    required this.pedido,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late String tratamento;
  late Future<List<dynamic>> produtos;
  final tratamentoController = TextEditingController();
  late int tipoProduto;
  bool visibility = false;

  @override
  void initState() {
    super.initState();
    fetchData();

    final result = Provider.of<AppConfig>(context, listen: false);

    if (result.accessories && result.profiles) {
      tipoProduto = 0;
    } else if (result.profiles) {
      tipoProduto = 2;
    } else if (result.accessories) {
      tipoProduto = 3;
    }

    produtos = Produtos().fetchProdutos(
      tipoProduto,
      int.parse(
        widget.pedido.id.toString(),
      ),
    );
  }

  fetchData() async {
    final pedido = await Pedidos().fetchOrdersByIdOrder(
      int.parse(
        widget.pedido.id.toString(),
      ),
    );

    if (pedido.tratamento == null || pedido.tratamento == '') {
      tratamento = '';
    } else {
      tratamento = pedido.tratamento!;

      final tratamentoInicial = await Tratamento().fetchTratamentoById(
        tratamento,
      );

      tratamentoController.text = tratamentoInicial.descricao.toString();
    }

    setState(() => _isVisible());
  }

  selecionarTratamento() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => Treatment(tratamento: tratamento),
      ),
    )
        .then(
      (value) async {
        if (value != null) {
          final result = await Tratamento().fetchTratamentoById(value);
          tratamentoController.text = result.descricao!;
        }
        setState(() {
          _isVisible();
        });
      },
    );
  }

  bool _isVisible() {
    if (tratamentoController.text == '') {
      visibility = false;
    } else {
      visibility = true;
    }

    return visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trat. quando utilizado Grupo Especial:',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Material(
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                    topRight: visibility
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomRight: visibility
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () => selecionarTratamento(),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      topRight: visibility
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                      bottomRight: visibility
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                    ),
                    child: TextField(
                      controller: tratamentoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_forward_ios_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visibility,
                child: Expanded(
                  child: Material(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    elevation: 5,
                    color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tratamentoController.clear();
                          visibility = false;
                        });
                      },
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder(
              future: produtos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var produto = snapshot.data![index];
                      return ProductListItem(
                          product: produto,
                          onTap: () {
                            showModal(context, produto);
                          });
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: Theme.of(context).indicatorColor,
                    size: 30,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
