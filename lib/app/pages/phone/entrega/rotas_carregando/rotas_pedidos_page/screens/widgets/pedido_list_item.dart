import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/repositories/configuracoes.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_pedidos_page/screens/produtos_pedido.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

import '../../../../../../../data/blocs/pedido_roteiro/pedido_roteiro_bloc.dart';

class PedidoListItem extends StatefulWidget {
  final int idPedido;
  final String numeroEntrega;
  final String cepEntrega;
  final int idCliente;
  final int idRoteiro;
  final int carregado;
  final int idStatus;
  final String setorEstoque;
  final String status;
  final int volumeAcessorio;
  final int volumeChapa;
  final int volumePerfil;
  final bool selecionado;
  final num pesoTotal;
  final String tratamento;
  final String tratamentoItens;
  final PedidoRoteiroBloc bloc;

  const PedidoListItem({
    super.key,
    required this.idPedido,
    required this.numeroEntrega,
    required this.cepEntrega,
    required this.idCliente,
    required this.idRoteiro,
    required this.carregado,
    required this.idStatus,
    required this.setorEstoque,
    required this.status,
    required this.volumeAcessorio,
    required this.volumeChapa,
    required this.volumePerfil,
    required this.selecionado,
    required this.pesoTotal,
    required this.tratamento,
    required this.tratamentoItens,
    required this.bloc,
  });

  @override
  State<PedidoListItem> createState() => _PedidoListItemState();
}

class _PedidoListItemState extends State<PedidoListItem> {
  bool selecionado = false;
  String label() {
    String result;
    widget.carregado == 1 ? result = 'Não Carregado' : result = 'Carregado';
    return result;
  }

  void update() async {
    if (widget.idStatus < 5 && widget.carregado == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomDialog(
            titulo: 'Atenção',
            conteudo: Text(
              'O pedido deve estar liberado para poder ser carregado',
              textAlign: TextAlign.center,
            ),
            tipo: Icones.alerta,
          );
        },
      );
    } else {
      bool separarAgrupamento =
          await Configuracoes().verificaConfiguracaoAgrupamento() == 1
              ? true
              : false;

      if (widget.carregado == 1) {
        widget.bloc.inputProdutoRoteiroController.add(
          DescarregarPedido(
            idPedido: widget.idPedido,
            numeroEntrega: widget.numeroEntrega,
            cepEntrega: widget.cepEntrega,
            idCliente: widget.idCliente,
            idRoteiro: widget.idRoteiro,
            separarAgrupamento: separarAgrupamento,
          ),
        );
      } else {
        widget.bloc.inputProdutoRoteiroController.add(
          CarregarPedido(
            idPedido: widget.idPedido,
            numeroEntrega: widget.numeroEntrega,
            cepEntrega: widget.cepEntrega,
            idCliente: widget.idCliente,
            idRoteiro: widget.idRoteiro,
            separarAgrupamento: separarAgrupamento,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                update();
              },
              backgroundColor:
                  widget.carregado == 1 ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
              icon: widget.carregado == 1 ? Icons.close : Icons.check,
              label: label(),
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
          elevation: 3,
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProdutosPedido(
                  idPedido: widget.idPedido,
                ),
              ),
            ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: widget.tratamentoItens == 'ESP',
                              child: Text(
                                'ESP.: ${widget.tratamento}',
                              ),
                            ),
                            Text(
                              widget.tratamentoItens,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Pedido ${widget.idPedido}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Setor Estoque: ${widget.setorEstoque}',
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(widget.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        '${widget.pesoTotal} Kg',
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            height: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.volumeAcessorio == 0 &&
                                  widget.volumeChapa == 0 &&
                                  widget.volumePerfil == 0
                              ? 'Nenhum Volume'
                              : 'Volumes'),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).dividerColor,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: widget.volumeAcessorio == 0 ? false : true,
                          child: volumeContainer(
                            'Acessórios: ${widget.volumeAcessorio}',
                          ),
                        ),
                        Visibility(
                          visible: widget.volumeAcessorio == 0 ? false : true,
                          child: const SizedBox(width: 8),
                        ),
                        Visibility(
                          visible: widget.volumeChapa == 0 ? false : true,
                          child: volumeContainer(
                            'Chapas: ${widget.volumeChapa}',
                          ),
                        ),
                        Visibility(
                          visible: widget.volumeChapa == 0 ? false : true,
                          child: const SizedBox(width: 8),
                        ),
                        Visibility(
                          visible: widget.volumePerfil == 0 ? false : true,
                          child: volumeContainer(
                            'Perfis: ${widget.volumePerfil}',
                          ),
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
    );
  }

  Container volumeContainer(String label) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        label,
      ),
    );
  }
}
