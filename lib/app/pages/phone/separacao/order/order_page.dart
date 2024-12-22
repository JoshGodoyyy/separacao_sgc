import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/conferencia_config.dart';
import 'package:sgc/app/config/embalagem_config.dart';
import 'package:sgc/app/config/separando_config.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/pages/phone/fotos_page/foto_pedido.dart';
import 'package:sgc/app/ui/utils/alterar_status_pedido.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:sgc/app/ui/widgets/loading_dialog.dart';
import '../../../../config/app_config.dart';
import '../../../../data/blocs/pedido/pedido_bloc.dart';
import '../../../../data/blocs/pedido/pedido_event.dart';
import '../../../../data/repositories/historico_pedido.dart';
import '../../../../models/historico_pedido_model.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/styles/colors_app.dart';
import 'pages/general_info_page/general_info.dart';
import 'pages/packaging_page/packaging.dart';
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
  late final PedidoBloc _pedidoBloc;

  Timer? timer;
  Duration tempoDecorrido = const Duration();

  bool iniciarSeparacao = false;
  bool liberarEmbalagem = false;
  bool liberarConferencia = false;
  bool finalizarSeparacao = false;

  final volumeAcessorioController = TextEditingController();
  final volumeAluminioController = TextEditingController();
  final volumeChapasController = TextEditingController();
  final observacoesSeparacaoController = TextEditingController();
  final observacoesSeparadorController = TextEditingController();
  final setorSeparacaoController = TextEditingController();
  final pesoAcessorioController = TextEditingController();
  final pesoController = TextEditingController();
  late PedidoModel pedido = PedidoModel();

  final DateFormat _data = DateFormat('yyyy-MM-dd HH:mm:ss');

  SituacaoFoto? situacaoFoto;

  SeparandoConfig? _separandoConfig;
  EmbalagemConfig? _embalagemConfig;
  ConferenciaConfig? _conferenciaConfig;

  @override
  void initState() {
    super.initState();
    _pedidoBloc = PedidoBloc();
    _separandoConfig = Provider.of<SeparandoConfig>(context, listen: false);
    _embalagemConfig = Provider.of<EmbalagemConfig>(context, listen: false);
    _conferenciaConfig = Provider.of<ConferenciaConfig>(context, listen: false);

    final result = Provider.of<AppConfig>(context, listen: false);

    if (result.accessories && result.profiles) {
      tipoProduto = 0;
    } else if (result.profiles) {
      tipoProduto = 2;
    } else if (result.accessories) {
      tipoProduto = 3;
    }

    modificarStatus();
    _fetchPedido();
  }

  _fetchPedido() async {
    pedido = await Pedido().fetchOrdersByIdOrder(
      int.parse(
        widget.pedido.id.toString(),
      ),
    );

    observacoesSeparacaoController.text =
        pedido.observacoesSeparacao.toString();

    setState(() {});
  }

  void clear() {
    codigoVendedorController.clear();
  }

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
        setState(() {
          iniciarSeparacao = false;
          situacaoFoto = SituacaoFoto.separando;
        });
        if (config.conferencia) {
          setState(() {
            liberarConferencia = true;
            situacaoFoto = SituacaoFoto.separando;
          });
        }
        if (config.embalagem) {
          setState(() => liberarEmbalagem = true);
        }
        if (!config.embalagem || config.conferencia) {
          setState(() => finalizarSeparacao = true);
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
        setState(() {
          liberarConferencia = false;
          finalizarSeparacao = true;
          situacaoFoto = SituacaoFoto.conferencia;
        });
        break;
      default:
        break;
    }
  }

  bool conferenciaVisibility() {
    bool value = false;

    if (widget.pedido.status != 'SEPARAR' && liberarConferencia) {
      switch (widget.pedido.status) {
        case 'SEPARANDO':
          value = _separandoConfig?.mostrarConferencia ?? true;
        case 'EMBALAGEM':
          value = _embalagemConfig?.mostrarConferencia ?? true;
          break;
        default:
          value = false;
          break;
      }
      return value;
    }

    return value;
  }

  bool embalagemVisibility() {
    bool value = false;

    if (widget.pedido.status != 'SEPARAR' && liberarConferencia) {
      switch (widget.pedido.status) {
        case 'SEPARANDO':
          value = _separandoConfig?.mostrarEmbalagem ?? true;
        case 'CONFERENCIA':
          value = _conferenciaConfig?.mostrarEmbalagem ?? true;
          break;
        default:
          value = false;
          break;
      }
      return value;
    }

    return value;
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
                maxLines: 2,
                textAlign: TextAlign.center,
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
              tratamentoEspecial: widget.pedido.tratamentoItens == 'ESP',
              observacoesSeparacaoController: observacoesSeparacaoController,
            ),
            Separation(
              ancestralContext: context,
              pedido: widget.pedido,
              tipoProduto: tipoProduto,
              volumeAcessorioController: volumeAcessorioController,
              volumeAluminioController: volumeAluminioController,
              volumeChapasController: volumeChapasController,
              observacoesSeparacaoController: observacoesSeparacaoController,
              observacoesSeparadorController: observacoesSeparadorController,
              setorSeparacaoController: setorSeparacaoController,
              pesoAcessorioController: pesoAcessorioController,
              pesoController: pesoController,
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
                    idStatus: 5,
                    status: 'OK',
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
                          return CustomDialog(
                            titulo: 'SGC Mobile',
                            conteudo: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pedido separado com sucesso',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            tipo: Icones.sucesso,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
                      );
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
                            conteudo: Text(
                              e.toString().substring(11),
                              textAlign: TextAlign.center,
                            ),
                            tipo: Icones.erro,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
            //* Liberar para Conferência
            SpeedDialChild(
              visible: conferenciaVisibility(),
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
                    idStatus: 15,
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
                          return CustomDialog(
                            titulo: 'SGC Mobile',
                            conteudo: const Text(
                              'Pedido enviado para conferência',
                              textAlign: TextAlign.center,
                            ),
                            tipo: Icones.sucesso,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
                      );
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
                            conteudo: Text(
                              e.toString().substring(11),
                              textAlign: TextAlign.center,
                            ),
                            tipo: Icones.erro,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
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
                  : embalagemVisibility(),
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
                    idStatus: 14,
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
                          return CustomDialog(
                            titulo: 'SGC Mobile',
                            conteudo: const Text(
                              'Pedido enviado para embalagem',
                              textAlign: TextAlign.center,
                            ),
                            tipo: Icones.sucesso,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
                      );
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
                            conteudo: Text(
                              e.toString().substring(11),
                              textAlign: TextAlign.center,
                            ),
                            tipo: Icones.erro,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then(
                        (value) => WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            Navigator.pop(context);
                          },
                        ),
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
                                id: 0,
                                idPedido: widget.pedido.id,
                                idStatus: 3,
                                status: 'SEPARANDO',
                                chaveFuncionario: UserConstants().idLiberacao,
                                data: _data.format(
                                  DateTime.now(),
                                ),
                                idUsuario: UserConstants().idUsuario,
                                nomeUsuario: UserConstants().userName,
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
                                      return CustomDialog(
                                        titulo: 'SGC Mobile',
                                        conteudo: const Text(
                                          'Processo iniciado com sucesso',
                                          textAlign: TextAlign.center,
                                        ),
                                        tipo: Icones.sucesso,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ).then(
                                    (value) => WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (_) {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
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
                                        conteudo: Text(
                                          e.toString().substring(11),
                                          textAlign: TextAlign.center,
                                        ),
                                        tipo: Icones.erro,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ).then(
                                    (value) => WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (_) {
                                        Navigator.pop(context);
                                      },
                                    ),
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
        bottomNavigationBar: Material(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          elevation: 15,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.inbox_rounded,
                  ),
                  label: 'Embalagens',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.save),
                  label: 'Salvar',
                ),
                if (situacaoFoto == SituacaoFoto.separando ||
                    situacaoFoto == SituacaoFoto.conferencia)
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt_rounded),
                    label: 'Foto',
                  ),
              ],
              selectedItemColor: Theme.of(context).iconTheme.color,
              unselectedItemColor: Theme.of(context).iconTheme.color,
              onTap: _selectedIndexChanged,
            ),
          ),
        ),
      ),
    );
  }

  _selectedIndexChanged(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => Packaging(pedido: widget.pedido),
          ),
        );
        break;
      case 1:
        if (volumeAcessorioController.text == '') {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Volume Acessório'),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );

          return;
        }

        if (volumeAluminioController.text == '') {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Volume Aluminio'),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );

          return;
        }

        if (volumeChapasController.text == '') {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Volume Chapas'),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );

          return;
        }

        if (pesoAcessorioController.text == '') {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Peso Acessório'),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );

          return;
        }

        _pedidoBloc.inputPedido.add(
          UpdatePedido(
            volAcessorio: double.parse(volumeAcessorioController.text),
            volAlum: double.parse(volumeAluminioController.text),
            volChapa: double.parse(volumeChapasController.text),
            obsSeparacao: observacoesSeparacaoController.text,
            obsSeparador: observacoesSeparadorController.text,
            setorEstoque: setorSeparacaoController.text,
            pesoAcessorio: double.parse(pesoAcessorioController.text),
            idPedido: int.parse(
              widget.pedido.id.toString(),
            ),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => FotoPedido(
              idPedido: int.parse(
                widget.pedido.id.toString(),
              ),
              situacaoFoto: situacaoFoto!,
              idCliente: 0,
              idRoteiro: 0,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
