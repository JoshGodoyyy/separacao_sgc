import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sgc/app/data/blocs/produto/produto_bloc.dart';
import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/models/colors.dart';

import '../../../../../../models/produto_model.dart';
import 'item_color.dart';

class ProdutoListItem extends StatelessWidget {
  final String status;
  final ProdutoModel produto;
  final ProdutoBloc bloc;
  final int tipoProduto;
  final int idPedido;

  final Function onTap;
  const ProdutoListItem({
    super.key,
    required this.status,
    required this.produto,
    required this.bloc,
    required this.onTap,
    required this.tipoProduto,
    required this.idPedido,
  });

  Color backColorActionPane() {
    Color cor;
    switch (status) {
      case 'SEPARANDO':
        produto.separado == false ? cor = Colors.blue : cor = Colors.red;
        break;
      case 'EMBALAGEM':
        produto.embalado == false ? cor = Colors.blue : cor = Colors.red;
        break;
      case 'CONFERENCIA':
        produto.conferido == false ? cor = Colors.blue : cor = Colors.red;
        break;
      default:
        cor = Colors.blue;
    }

    return cor;
  }

  alteracao() {
    switch (status) {
      case 'SEPARANDO':
        if (!produto.separado!) {
          return bloc.inputProdutoController.add(
            UpdateSeparacao(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              separado: 1,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        } else {
          return bloc.inputProdutoController.add(
            UpdateSeparacao(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              separado: 0,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        }
      case 'EMBALAGEM':
        if (!produto.embalado!) {
          return bloc.inputProdutoController.add(
            UpdateEmbalagem(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              embalado: 1,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        } else {
          return bloc.inputProdutoController.add(
            UpdateEmbalagem(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              embalado: 0,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        }
      case 'CONFERENCIA':
        if (!produto.conferido!) {
          return bloc.inputProdutoController.add(
            UpdateConferencia(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              conferido: 1,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        } else {
          return bloc.inputProdutoController.add(
            UpdateConferencia(
              idProduto: int.parse(
                produto.id.toString(),
              ),
              conferido: 0,
              tipoProduto: tipoProduto,
              idPedido: idPedido,
            ),
          );
        }
    }
  }

  String texto() {
    String result = '';
    switch (status) {
      case 'SEPARANDO':
        produto.separado == false
            ? result = 'Separado'
            : result = 'Não Separado';
        break;
      case 'EMBALAGEM':
        produto.embalado == false
            ? result = 'Embalado'
            : result = 'Não Embalado';
        break;
      case 'CONFERENCIA':
        produto.conferido == false
            ? result = 'Conferido'
            : result = 'Não Conferido';
        break;
      default:
        result = '';
        break;
    }
    return result;
  }

  IconData? icone() {
    IconData? icone;
    switch (status) {
      case 'SEPARANDO':
        produto.separado == false
            ? icone = Icons.check
            : icone = Icons.close_rounded;
        break;
      case 'EMBALAGEM':
        produto.embalado == false
            ? icone = Icons.check
            : icone = Icons.close_rounded;
        break;
      case 'CONFERENCIA':
        produto.conferido == false
            ? icone = Icons.check
            : icone = Icons.close_rounded;
        break;
      default:
        icone = null;
        break;
    }
    return icone;
  }

  Widget item(BuildContext context) {
    if (status != 'SEPARAR' && status != 'OK') {
      return Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => alteracao(),
              backgroundColor: backColorActionPane(),
              foregroundColor: Colors.white,
              icon: icone(),
              label: texto(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            )
          ],
        ),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => onTap(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      );
    } else {
      return Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 5,
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: item(context),
    );
  }
}
