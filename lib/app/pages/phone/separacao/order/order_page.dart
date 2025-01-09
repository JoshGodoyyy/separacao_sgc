import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/embalagem_config.dart';
import 'package:sgc/app/config/separando_config.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
import 'package:sgc/app/data/repositories/empresa.dart';
import 'package:sgc/app/data/repositories/fornecedor.dart';
import 'package:sgc/app/data/repositories/generica.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/data/repositories/vendedor_dao.dart';
import 'package:sgc/app/models/fornecedor_model.dart';
import 'package:sgc/app/pages/phone/fotos_page/foto_pedido.dart';
import 'package:sgc/app/ui/utils/alterar_status_pedido.dart';
import 'package:sgc/app/ui/utils/impressao_utils.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';
import 'package:sgc/app/ui/widgets/loading_dialog.dart';
import '../../../../config/app_config.dart';
import '../../../../data/blocs/pedido/pedido_bloc.dart';
import '../../../../data/blocs/pedido/pedido_event.dart';
import '../../../../data/repositories/historico_pedido.dart';
import '../../../../data/repositories/impressora.dart';
import '../../../../data/repositories/produto.dart';
import '../../../../models/historico_pedido_model.dart';
import '../../../../models/pedido_model.dart';
import '../../../../ui/styles/colors_app.dart';
import 'pages/general_info_page/general_info.dart';
import 'pages/packaging_page/packaging.dart';
import 'pages/products_page/products.dart';
import 'pages/separation_page/separation.dart';
import 'dart:developer' as developer;

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

  AppConfig? _config;
  SeparandoConfig? _separandoConfig;
  EmbalagemConfig? _embalagemConfig;

  @override
  void initState() {
    super.initState();
    _pedidoBloc = PedidoBloc();
    _config = Provider.of<AppConfig>(context, listen: false);
    _separandoConfig = Provider.of<SeparandoConfig>(context, listen: false);
    _embalagemConfig = Provider.of<EmbalagemConfig>(context, listen: false);

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
    switch (widget.pedido.status!.toUpperCase()) {
      case 'SEPARAR':
        setState(() => iniciarSeparacao = true);
        break;
      case 'SEPARANDO':
        setState(() {
          iniciarSeparacao = false;
          situacaoFoto = SituacaoFoto.separando;
          liberarConferencia = _separandoConfig!.mostrarConferencia;
          liberarEmbalagem = _separandoConfig!.mostrarEmbalagem;
          finalizarSeparacao = _separandoConfig!.mostrarFaturar;
        });
        break;
      case 'EMBALAGEM':
        setState(() {
          liberarConferencia = _embalagemConfig!.mostrarConferencia;
          finalizarSeparacao = _embalagemConfig!.mostrarFaturar;
        });
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

  bool visibilityImpressora() {
    bool value = false;

    if (widget.pedido.status == 'CONFERENCIA') {
      value = true;
      return value;
    }

    if (widget.pedido.status == 'SEPARANDO' && !_config!.conferencia) {
      value = true;
      return value;
    }

    return value;
  }

  _printEtiqueta() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            titulo: 'SGC Mobile',
            conteudo: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(width: 12),
                  Text(
                    'Imprimindo...',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            tipo: Icones.info,
            actions: [],
          );
        },
      );

      var volumeTotal = int.parse(widget.pedido.volumeAcessorio.toString()) +
          int.parse(widget.pedido.volumeChapa.toString()) +
          int.parse(widget.pedido.volumePerfil.toString());

      String codigoEtiqueta = await Impressora().fetchZpl();

      if (_config!.printerIp == '' || _config!.printerPort == '') {
        throw Exception('Impressora não configurada');
      }

      var futures = await Future.wait([
        Empresa().fetchEmpresa(1),
        VendedorDAO().fetchVendedor(
          int.parse(
            widget.pedido.idVendedor.toString(),
          ),
        ),
      ]);

      var empresa = futures[0];

      var vendedor = futures[1];

      DateFormat data = DateFormat('dd/MM/yyyy');

      FornecedorModel? transportadora;

      if (widget.pedido.idFornNFe != null && widget.pedido.idFornNFe! > 0) {
        transportadora = await Fornecedor().fetchFornecedor(
          int.parse(
            widget.pedido.idFornNFe.toString(),
          ),
        );
      }

      int totalProdutos = await Produto().getTotalProdutos(
          int.parse(
            widget.pedido.id.toString(),
          ),
          tipoProduto);

      for (int i = 0; i < volumeTotal; i++) {
        String zpl = '';
        List<Generica> campos = [];

        campos.addAll(
          [
            Generica(id: 'C_EMPRESA_NOME', descricao: empresa.nome),
            Generica(id: 'C_EMPRESA_TELEFONE', descricao: empresa.telefone),
          ],
        );

        if (widget.pedido.nnFeRemessa.toString() == '') {
          campos.addAll([
            Generica(
                id: 'C_NFE_REMESSA',
                descricao: widget.pedido.nnFeRemessa.toString()),
            Generica(
                id: 'C_REMESSA_NOME', descricao: widget.pedido.fantasiaTri),
            Generica(
                id: 'C_REMESSA_CIDADE', descricao: widget.pedido.cidadeTri),
            Generica(
                id: 'C_REMESSA_ESTADO', descricao: widget.pedido.estadoTri),
          ]);
        } else {
          campos.addAll([
            Generica(id: 'C_REMESSA_NOME', descricao: ''),
            Generica(id: 'C_REMESSA_CIDADE', descricao: ''),
            Generica(id: 'C_REMESSA_ESTADO', descricao: ''),
          ]);
        }

        campos.addAll([
          Generica(
              id: 'C_NFE_VENDA', descricao: widget.pedido.nnFeVenda.toString()),
          Generica(id: 'C_CLIENTE_NOME', descricao: widget.pedido.nomeCliente),
          Generica(id: 'C_CLIENTE_CIDADE', descricao: widget.pedido.cidade),
          Generica(id: 'C_CLIENTE_ESTADO', descricao: widget.pedido.estado),
          Generica(
              id: 'C_CLIENTE_SETORENTREGA',
              descricao: widget.pedido.setorEntrega),
          Generica(
              id: 'C_PEDIDO_TIPOENTREGA', descricao: widget.pedido.tipoEntrega),
          Generica(
              id: 'C_TRANSPORTADOR_NOME',
              descricao: transportadora?.fantasia ?? ''),
          Generica(
              id: 'C_PEDIDO_PEDIDOCLIENTE',
              descricao: widget.pedido.idPedidoCliente),
          Generica(id: 'C_PEDIDO_REPRESENTANTE', descricao: vendedor.nome),
          Generica(
              id: 'C_PEDIDO_SEPARADOR',
              descricao: widget.pedido.separadorConcluir ?? ''),
          Generica(id: 'C_DATA_ATUAL', descricao: data.format(DateTime.now())),
          Generica(id: 'C_PEDIDO_ID', descricao: widget.pedido.id.toString()),
          Generica(id: 'C_PEDIDO_VOLUMEATUAL', descricao: (i + 1).toString()),
          Generica(id: 'C_PEDIDO_VOLUMES', descricao: volumeTotal.toString()),
          Generica(id: 'C_EMBALAGEM_IDCAIXA', descricao: ''),
          Generica(id: 'C_QTDE_PRODUTOS', descricao: totalProdutos.toString()),
        ]);

        var corpo = ImpressaoUtils().processarCorpo(codigoEtiqueta, campos);

        developer.log(corpo.toString());

        for (String item in corpo.split('\n')) {
          zpl += item;
        }

        final socket = await Socket.connect(
          _config!.printerIp,
          int.parse(_config!.printerPort),
          timeout: Duration(seconds: 5),
        );

        socket.write(zpl);
        await socket.flush();
        socket.destroy();
      }

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Navigator.pop(context);
        },
      );
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                titulo: 'SGC Mobile',
                conteudo: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    ex.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                tipo: Icones.erro,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
      );
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
          actions: [
            Visibility(
              visible: visibilityImpressora(),
              child: IconButton(
                onPressed: () async {
                  await _printEtiqueta();
                },
                icon: const Icon(Icons.print),
              ),
            ),
          ],
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
              visible: liberarConferencia,
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
              visible:
                  UserConstants().idLiberacao == '' ? false : liberarEmbalagem,
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
          elevation: 15,
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
        if (volumeAcessorioController.text != '' &&
            volumeAcessorioController.text != '0' &&
            (pesoAcessorioController.text == '' ||
                pesoAcessorioController.text == '0')) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Peso'),
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

        if (volumeAcessorioController.text == '0' &&
            volumeAluminioController.text == '0' &&
            volumeChapasController.text == '0') {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                titulo: 'Sistema SGC',
                conteudo: const Text('Preencher Volumes'),
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
