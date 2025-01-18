import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/blocs/produto/produto_bloc.dart';
import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/data/blocs/produto/produto_state.dart';

import '../../../../../../models/colors.dart';
import '../../../../../../ui/widgets/error_alert.dart';
import '../../../../separacao/order/pages/products_page/widgets/item_color.dart';

class ProdutosPedido extends StatefulWidget {
  final int idPedido;
  const ProdutosPedido({
    super.key,
    required this.idPedido,
  });

  @override
  State<ProdutosPedido> createState() => _ProdutosPedidoState();
}

class _ProdutosPedidoState extends State<ProdutosPedido> {
  late ProdutoBloc produtoBloc;
  late int tipoProduto;
  late bool _perfis;
  late bool _acessorios;
  late bool _chapas;
  late bool _vidros;
  late bool _kits;

  @override
  void initState() {
    super.initState();

    produtoBloc = ProdutoBloc();

    final result = Provider.of<AppConfig>(context, listen: false);

    _perfis = result.profiles;
    _acessorios = result.accessories;
    _chapas = result.chapas;
    _vidros = result.vidros;
    _kits = result.kits;

    _fetchData();
  }

  _fetchData() {
    produtoBloc.inputProdutoController.add(
      GetProdutos(
        acessorios: _acessorios,
        chapas: _chapas,
        kits: _kits,
        perfis: _perfis,
        vidros: _vidros,
        idPedido: widget.idPedido,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${widget.idPedido}'),
        centerTitle: true,
      ),
      body: StreamBuilder<ProdutoState>(
        stream: produtoBloc.outputProdutoController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data is ProdutoLoadingState) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: LinearProgressIndicator(),
              ),
            );
          } else if (snapshot.data is ProdutoLoadedState) {
            List produtos = snapshot.data?.produtos ?? [];
            return ListView(
              children: [
                for (var produto in produtos)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Material(
                      elevation: 5,
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      produto.idProduto.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ItemColor(
                                      cor: Cor(
                                        '',
                                        Color.fromARGB(
                                          produto.cor!['a'],
                                          produto.cor!['r'],
                                          produto.cor!['g'],
                                          produto.cor!['b'],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${produto.quantidade} ${produto.idUnidade}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  produto.descricao.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Peso Unit.: ${produto.peso}',
                                    ),
                                    Text(
                                      'Peso Tot.: ${produto.pesoTotal}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
    );
  }
}
