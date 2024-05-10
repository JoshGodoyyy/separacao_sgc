import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgc/app/data/blocs/produtos_estoque/produtos_estoque_bloc.dart';
import 'package:sgc/app/data/blocs/produtos_estoque/produtos_estoque_event.dart';
import 'package:sgc/app/data/blocs/produtos_estoque/produtos_estoque_state.dart';

import '../../../ui/styles/colors_app.dart';
import '../../../ui/widgets/error_alert.dart';

class ConsultarEstoque extends StatefulWidget {
  const ConsultarEstoque({super.key});

  @override
  State<ConsultarEstoque> createState() => _ConsultarEstoqueState();
}

class _ConsultarEstoqueState extends State<ConsultarEstoque> {
  late ProdutosEstoqueBloc _bloc;

  bool carregando = false;

  @override
  void initState() {
    super.initState();
    _bloc = ProdutosEstoqueBloc();
    _fetchData();
  }

  _fetchData() {
    setState(() => carregando = true);
    _bloc.inputProdutosEstoqueController.add(
      GetProdutosEstoque(),
    );
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: TextField(
                    // controller: searchController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                    ],
                    onChanged: (value) {
                      // if (searchController.text == '') {
                      //   search = '';
                      //   fetchData();
                      // } else {
                      //   search = searchController.text;
                      //   fetchData();
                      // }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Pesquisar',
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 5,
                color: ColorsApp.primaryColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    // if (searchController.text == '') {
                    //   search = '';
                    //   fetchData();
                    // } else {
                    //   search = searchController.text;
                    //   fetchData();
                    // }
                  },
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<ProdutosEstoqueState>(
            stream: _bloc.outputProdutosEstoqueController,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data is ProdutosEstoqueLoadingState) {
                return Container();
              } else if (snapshot.data is ProdutosEstoqueLoadedState) {
                List produtosEstoque = snapshot.data?.produtosEstoque ?? [];

                return ListView(
                  children: [
                    for (var produto in produtosEstoque)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            elevation: 5,
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    caption('Código: ${produto.codigo ?? ''}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        caption(
                                          'Trat.: ${produto.idTratamento ?? ''}',
                                        ),
                                        caption(
                                            'Linha (ID): ${produto.linha ?? ''}'),
                                        caption(
                                            'Unid.: ${produto.idUnidade ?? ''}'),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          produto.descricao ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        caption('Peso: ${produto.peso ?? ''}'),
                                        caption(
                                            'Estoque: ${produto.estoque ?? ''}'),
                                        caption(
                                            'Pedido: ${produto.pedido ?? ''}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        caption(
                                            'Enc. Livre: ${produto.encomendaLivre ?? ''}'),
                                        caption(
                                            'Enc. Reserv.: ${produto.encomendaReservada ?? ''}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        caption(
                                            'Enc. Total: ${produto.encomenda ?? ''}'),
                                        caption(
                                            'Para Benef.: ${produto.tratandoOriginal ?? ''}'),
                                      ],
                                    ),
                                    caption('Saldo: ${produto.saldo ?? '0'}')
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
        ),
      ],
    );
  }

  Text caption(String label) => Text(
        label,
        style: const TextStyle(fontSize: 16),
      );
}
