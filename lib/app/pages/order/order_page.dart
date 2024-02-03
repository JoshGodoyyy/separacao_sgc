import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/enums/situacao_pedido.dart';
import 'package:sgc/app/pages/order/pages/packaging_page/packaging.dart';
import 'package:sgc/app/ui/utils/alterar_status_pedido.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:sgc/app/ui/widgets/loading_dialog.dart';
import '../../config/app_config.dart';
import '../../data/repositories/grupo.dart';
import '../../data/repositories/grupo_pedido.dart';
import '../../data/repositories/historico_pedido.dart';
import '../../data/repositories/produto.dart';
import '../../models/historico_pedido_model.dart';
import '../../ui/styles/colors_app.dart';
import 'pages/general_info_page/general_info.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';
import '../../models/pedido_model.dart';

class OrderPage extends StatefulWidget {
  final PedidoModel pedido;
  const OrderPage({
    super.key,
    required this.pedido,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final codigoVendedorController = TextEditingController();
  late int tipoProduto;

  @override
  void initState() {
    super.initState();
    final result = Provider.of<AppConfig>(context, listen: false);

    if (result.accessories && result.profiles) {
      tipoProduto = 0;
    } else if (result.profiles) {
      tipoProduto = 2;
    } else if (result.accessories) {
      tipoProduto = 3;
    }
  }

  void clear() {
    codigoVendedorController.clear();
  }

  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  late Timer timer;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSecond,
      (timer) {
        setState(
          () {
            _seconds++;
            if (_seconds == 60) {
              _seconds = 0;
              _minutes++;
              if (_minutes == 60) {
                _minutes = 0;
                _hours++;
              }
            }
          },
        );
      },
    );
  }

  String durationValue() {
    String result;
    String hours = _hours.toString().padLeft(2, '0');
    String minutes = _minutes.toString().padLeft(2, '0');
    String seconds = _seconds.toString().padLeft(2, '0');

    _seconds == 0
        ? result = 'Não Iniciado'
        : result = '$hours:$minutes:$seconds';

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.pedido.id} - ${widget.pedido.nomeCliente}',
              ),
              Text(
                'Duração: ${durationValue()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorsApp.primaryColor,
            tabs: [
              Tab(
                text: 'Dados Gerais',
              ),
              Tab(
                text: 'Produtos',
              ),
              Tab(
                text: 'Separação',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GeneralInfo(
              idPedido: int.parse(
                widget.pedido.id.toString(),
              ),
            ),
            Products(
              pedido: widget.pedido,
              tipoProduto: tipoProduto,
            ),
            Separation(
              ancestralContext: context,
              pedido: widget.pedido,
              tipoProduto: tipoProduto,
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          iconTheme: const IconThemeData(color: Colors.white),
          overlayOpacity: 0.6,
          backgroundColor: ColorsApp.primaryColor,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.shopping_cart_outlined),
              label: 'Finalizar Separação',
              onTap: () async {
                try {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const LoadingDialog();
                    },
                  );

                  await GrupoPedido().apagarGruposInconsistentes(
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                  );

                  var grupos = await Grupo().fetchGrupos(
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                    tipoProduto,
                  );

                  var produtos = await Produto().fetchProdutos(
                    tipoProduto,
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                  );

                  await Grupo().atualizarGruposPedidos(
                    grupos,
                    produtos,
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        titulo: 'SGC Mobile',
                        descricao: e.toString().substring(11),
                        tipo: Icones.erro,
                      );
                    },
                  ).then(
                    (value) => Navigator.pop(context),
                  );
                }
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.checklist_rtl_rounded),
              label: 'Liberar para Conferência',
              onTap: () async {
                try {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const LoadingDialog();
                    },
                  );

                  await AlterarStatusPedido().liberarConferencia(
                    widget.pedido.status.toString().toUpperCase(),
                    widget.pedido.observacoesSeparacao.toString(),
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                  );

                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Navigator.pop(context);
                    },
                  );

                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialog(
                            titulo: 'SGC Mobile',
                            descricao: 'Pedido separado com sucesso',
                            tipo: Icones.sucesso,
                          );
                        },
                      ).then((value) => Navigator.pop(context));
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        titulo: 'SGC Mobile',
                        descricao: e.toString().substring(11),
                        tipo: Icones.erro,
                      );
                    },
                  ).then(
                    (value) => Navigator.pop(context),
                  );
                }
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.archive),
              label: 'Liberar para Embalagem',
              onTap: () async {
                try {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const LoadingDialog();
                    },
                  );

                  await AlterarStatusPedido().enviarEmbalagem(
                    widget.pedido.status.toString().toUpperCase(),
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                    tipoProduto,
                    widget.pedido.observacoesSeparacao.toString(),
                  );

                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      Navigator.pop(context);
                    },
                  );

                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialog(
                            titulo: 'SGC Mobile',
                            descricao: 'Pedido separado com sucesso',
                            tipo: Icones.sucesso,
                          );
                        },
                      ).then((value) => Navigator.pop(context));
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        titulo: 'SGC Mobile',
                        descricao: e.toString().substring(11),
                        tipo: Icones.erro,
                      );
                    },
                  ).then(
                    (value) => Navigator.pop(context),
                  );
                }
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_walk_outlined),
              label: 'Iniciar Separação',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'SGC',
                      ),
                      content: const Text(
                        'Deseja iniciar separação?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            try {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const LoadingDialog();
                                },
                              );

                              await AlterarStatusPedido().enviarSeparacao(
                                SituacaoPedido.separando,
                                int.parse(
                                  widget.pedido.autorizado.toString(),
                                ),
                                int.parse(
                                  widget.pedido.id.toString(),
                                ),
                                tipoProduto,
                                widget.pedido.dataEnvioSeparacao.toString(),
                              );

                              final DateFormat data =
                                  DateFormat('yyyy-MM-dd HH:mm:ss');

                              var historico = HistoricoPedidoModel(
                                idPedido: widget.pedido.id,
                                idStatus: widget.pedido.idSituacao,
                                status: widget.pedido.status,
                                chaveFuncionario: UserConstants().idLiberacao,
                                data: data.format(
                                  DateTime.now(),
                                ),
                                idUsuario: UserConstants().idUsuario,
                              );

                              await HistoricoPedido()
                                  .adicionarHistorico(historico);

                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  Navigator.pop(context);
                                },
                              );

                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomDialog(
                                        titulo: 'SGC Mobile',
                                        descricao:
                                            'Processo iniciado com sucesso',
                                        tipo: Icones.sucesso,
                                      );
                                    },
                                  ).then((value) => Navigator.pop(context));
                                },
                              );
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    titulo: 'SGC Mobile',
                                    descricao: e.toString().substring(11),
                                    tipo: Icones.erro,
                                  );
                                },
                              ).then(
                                (value) => Navigator.pop(context),
                              );
                            }
                            //startTimer();
                          },
                          child: const Text(
                            'Sim',
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Não',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.inbox),
              label: 'Embalagens',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => Packaging(pedido: widget.pedido),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
