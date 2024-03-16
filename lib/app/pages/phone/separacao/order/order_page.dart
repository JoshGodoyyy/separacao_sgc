import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/enums/situacao_pedido.dart';
import 'package:sgc/app/ui/utils/alterar_status_pedido.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:sgc/app/ui/widgets/loading_dialog.dart';
import '../../../../config/app_config.dart';
import '../../../../data/repositories/historico_pedido.dart';
import '../../../../models/historico_pedido_model.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/styles/colors_app.dart';
import 'pages/general_info_page/general_info.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';

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
  Timer? timer;
  Duration tempoDecorrido = const Duration();
  bool iniciarSeparacao = false;
  bool liberarEmbalagem = false;
  bool liberarConferencia = false;
  bool finalizarSeparacao = false;

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

    modificarStatus();
  }

  void clear() {
    codigoVendedorController.clear();
  }

  final DateFormat _data = DateFormat('yyyy-MM-dd HH:mm:ss');

  iniciarContador(DateTime dataInicial) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          tempoDecorrido = DateTime.now().difference(dataInicial);
        });
      }
    });
  }

  String formatarDuracao(Duration duration) {
    String duasCasas(int n) {
      if (n >= 10) {
        return '$n';
      } else {
        return '0$n';
      }
    }

    String horas = duasCasas(duration.inHours);
    String minutos = duasCasas(duration.inMinutes.remainder(60));
    String segundos = duasCasas(duration.inSeconds.remainder(60));

    return '$horas:$minutos:$segundos';
  }

  String durationValue() {
    switch (widget.pedido.status) {
      case 'SEPARAR':
        return 'Não Iniciada';
      case 'SEPARANDO':
        iniciarContador(
          DateTime.parse(
            widget.pedido.dataEnvioSeparacao.toString(),
          ),
        );
        return formatarDuracao(tempoDecorrido);
      case 'CONFERENCIA':
        return 'Conferência';
      default:
        final dataInicial = DateTime.parse(
          widget.pedido.dataEnvioSeparacao.toString(),
        );
        final dataTermino = DateTime.parse(
          widget.pedido.dataRetornoSeparacao.toString(),
        );

        final prazo = dataTermino.difference(dataInicial);

        String hh = prazo.inHours.toString().padLeft(2, '0');
        String mm = prazo.inMinutes.remainder(60).toString().padLeft(2, '0');
        String ss = prazo.inSeconds.remainder(60).toString().padLeft(2, '0');

        return '$hh:$mm:$ss';
    }
  }

  void modificarStatus() {
    final config = Provider.of<AppConfig>(context, listen: false);

    switch (widget.pedido.status!.toUpperCase()) {
      case 'SEPARAR':
        setState(() => iniciarSeparacao = true);
        break;
      case 'SEPARANDO':
        setState(() => iniciarSeparacao = false);
        setState(() => liberarConferencia = true);
        if (config.embalagem) {
          setState(() => liberarEmbalagem = true);
        }
        break;
      case 'EMBALAGEM':
        if (config.conferencia) {
          setState(() => liberarConferencia = true);
        } else {
          setState(() => finalizarSeparacao = true);
        }
        break;
      case 'CONFERENCIA':
        setState(() => finalizarSeparacao = true);
        break;
      default:
        break;
    }
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
                durationValue(),
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
              status: widget.pedido.status ?? '',
              usuarioCriador: widget.pedido.criador ?? '',
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          icon: Icons.menu,
          iconTheme: const IconThemeData(color: Colors.white),
          overlayOpacity: 0.6,
          backgroundColor: ColorsApp.primaryColor,
          children: [
            //* Finalizar Separação
            SpeedDialChild(
              visible: UserConstants().idLiberacao == ''
                  ? false
                  : finalizarSeparacao
                      ? true
                      : false,
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

                  await AlterarStatusPedido().finalizarSeparacao(
                    widget.pedido.status.toString().toUpperCase(),
                    widget.pedido.observacoesSeparacao.toString(),
                    int.parse(
                      widget.pedido.volumePerfil.toString(),
                    ),
                    int.parse(
                      widget.pedido.volumeAcessorio.toString(),
                    ),
                    int.parse(
                      widget.pedido.volumeChapa.toString(),
                    ),
                    double.parse(
                      widget.pedido.pesoTotalTeorico.toString(),
                    ),
                    double.parse(
                      widget.pedido.valorTotalTeorico.toString(),
                    ),
                    tipoProduto,
                    int.parse(
                      widget.pedido.id.toString(),
                    ),
                  );

                  var historico = HistoricoPedidoModel(
                    idPedido: widget.pedido.id,
                    idStatus: widget.pedido.idSituacao,
                    status: 'FATURAR',
                    chaveFuncionario: UserConstants().idLiberacao,
                    data: _data.format(
                      DateTime.now(),
                    ),
                    idUsuario: UserConstants().idUsuario,
                  );

                  await HistoricoPedido().adicionarHistorico(historico);

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
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
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
                    },
                  );
                }
              },
            ),
            //* Liberar para Conferência
            SpeedDialChild(
              visible: UserConstants().idLiberacao == ''
                  ? false
                  : liberarConferencia
                      ? true
                      : false,
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

                  var historico = HistoricoPedidoModel(
                    idPedido: widget.pedido.id,
                    idStatus: widget.pedido.idSituacao,
                    status: 'CONFERENCIA',
                    chaveFuncionario: UserConstants().idLiberacao,
                    data: _data.format(
                      DateTime.now(),
                    ),
                    idUsuario: UserConstants().idUsuario,
                  );

                  await HistoricoPedido().adicionarHistorico(historico);

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
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
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
                    },
                  );
                }
              },
            ),
            //* Liberar para Embalagem
            SpeedDialChild(
              visible: UserConstants().idLiberacao == ''
                  ? false
                  : liberarEmbalagem
                      ? true
                      : false,
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

                  var historico = HistoricoPedidoModel(
                    idPedido: widget.pedido.id,
                    idStatus: widget.pedido.idSituacao,
                    status: 'EMBALAGEM',
                    chaveFuncionario: UserConstants().idLiberacao,
                    data: _data.format(
                      DateTime.now(),
                    ),
                    idUsuario: UserConstants().idUsuario,
                  );

                  await HistoricoPedido().adicionarHistorico(historico);

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
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
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
                    },
                  );
                }
              },
            ),
            //* Iniciar Separação
            SpeedDialChild(
              visible: UserConstants().idLiberacao == ''
                  ? false
                  : iniciarSeparacao
                      ? true
                      : false,
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
                                int.parse(
                                  widget.pedido.idSituacao.toString(),
                                ),
                                widget.pedido.status!,
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

                              var historico = HistoricoPedidoModel(
                                idPedido: widget.pedido.id,
                                idStatus: widget.pedido.idSituacao,
                                status: widget.pedido.status,
                                chaveFuncionario: UserConstants().idLiberacao,
                                data: _data.format(
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

                              widget.pedido.status = 'SEPARANDO';
                              widget.pedido.dataEnvioSeparacao =
                                  DateTime.now().toString();
                              modificarStatus();
                              durationValue();
                            } catch (e) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
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
                                },
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
