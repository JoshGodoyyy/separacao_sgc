import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sgc/app/config/user.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_bloc.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/repositories/roteiro_entrega.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/cliente_page/pages/ordem_entrega.dart';

import '../../../../../../data/blocs/roteiro_entrega/roteiro_event.dart';
import '../../../../../../data/enums/icones.dart';
import '../../../../../../data/enums/situacao_foto.dart';
import '../../../../../../ui/styles/colors_app.dart';
import '../../../../../../ui/widgets/custom_dialog.dart';
import '../../../../fotos_page/foto_pedido.dart';
import '../widgets/cliente_list_item.dart';

class ClientesPage extends StatefulWidget {
  final RoteiroEntregaModel dados;
  final RoteiroBloc roteiroBloc;
  final ClienteBloc clienteBloc;
  final List clientes;
  final bool agrupamentoPedidos;

  const ClientesPage({
    super.key,
    required this.clientes,
    required this.dados,
    required this.roteiroBloc,
    required this.clienteBloc,
    required this.agrupamentoPedidos,
  });

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  _desbloqueioVisivel() {
    if (widget.dados.chaveBloqueioRoteiro == '' ||
        widget.dados.chaveBloqueioRoteiro == null ||
        widget.dados.chaveBloqueioRoteiro == UserConstants().idLiberacao) {
      return true;
    }

    return false;
  }

  _concluirCarregamento() async {
    int pedidosCarregados = 0;
    int quantidadePedidos = 0;

    for (var cliente in widget.clientes) {
      pedidosCarregados += int.parse(
        cliente.pedidosCarregados.toString(),
      );
      quantidadePedidos += int.parse(
        cliente.quantidadePedidos.toString(),
      );
    }

    if (pedidosCarregados < quantidadePedidos) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            titulo: 'Sistema SGC',
            conteudo: const Text(
              'Ainda existem pedidos não carregados',
              textAlign: TextAlign.center,
            ),
            tipo: Icones.alerta,
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
        (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
        }),
      );
    } else {
      widget.roteiroBloc.inputRoteiroController.add(
        ConcluirCarregamento(
          idRoteiro: int.parse(
            widget.dados.id.toString(),
          ),
        ),
      );

      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            titulo: 'Sistema SGC',
            conteudo: const Text(
              'Roteiro carregado com sucesso! Liberado para entrega',
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
      )
          .then(
            (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            }),
          )
          .then(
            (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            }),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var cliente in widget.clientes)
            ClienteListItem(
              cliente: cliente,
              roteiroEntrega: widget.dados,
              bloc: widget.clienteBloc,
              agrupamentoPedidos: widget.agrupamentoPedidos,
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => FotoPedido(
                      idPedido: int.parse(
                        widget.dados.id.toString(),
                      ),
                      situacaoFoto: SituacaoFoto.carregado,
                      idRoteiro: int.parse(
                        widget.dados.id.toString(),
                      ),
                      idCliente: 0,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.camera_alt,
              ),
            ),
            const SizedBox(width: 8),
            SpeedDial(
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
                SpeedDialChild(
                  child: const Icon(Icons.check),
                  label: 'Concluir',
                  backgroundColor: Colors.green,
                  labelBackgroundColor: Colors.green,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          titulo: 'Sistema SGC',
                          conteudo: const Text(
                            'Deseja mesmo concluir o carregamento?',
                          ),
                          tipo: Icones.pergunta,
                          actions: [
                            TextButton(
                              onPressed: () => _concluirCarregamento(),
                              child: const Text('Sim'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Não'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.filter_list),
                  label: 'Reordenar',
                  backgroundColor: Colors.orange,
                  labelBackgroundColor: Colors.orange,
                  onTap: () {
                    int pedidosCarregados = 0;
                    for (var cliente in widget.clientes) {
                      pedidosCarregados += int.parse(
                        cliente.pedidosCarregados.toString(),
                      );
                    }

                    if (pedidosCarregados > 0) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            titulo: 'Sistema SGC',
                            conteudo: const Text(
                              'Não é possível reordenar a rota, já existem pedidos carregados',
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
                      );
                    } else {
                      if (!_desbloqueioVisivel()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              titulo: 'Sistema SGC',
                              conteudo: const Text(
                                'Roteiro bloqueado por outro usuário',
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
                        );
                        return;
                      }
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OrdemEntrega(
                            dados: widget.dados,
                            pedidosNaoOrdenados: false,
                          ),
                        ),
                      );
                    }
                  },
                ),
                SpeedDialChild(
                  visible: _desbloqueioVisivel(),
                  child: widget.dados.chaveBloqueioRoteiro == '' ||
                          widget.dados.chaveBloqueioRoteiro == null
                      ? const Icon(Icons.lock_outline_rounded)
                      : const Icon(Icons.lock_open_rounded),
                  label: widget.dados.chaveBloqueioRoteiro == '' ||
                          widget.dados.chaveBloqueioRoteiro == null
                      ? 'Bloquear roteiro'
                      : 'Desbloquear roteiro',
                  backgroundColor: widget.dados.chaveBloqueioRoteiro == '' ||
                          widget.dados.chaveBloqueioRoteiro == null
                      ? Colors.red
                      : Colors.green,
                  labelBackgroundColor:
                      widget.dados.chaveBloqueioRoteiro == '' ||
                              widget.dados.chaveBloqueioRoteiro == null
                          ? Colors.red
                          : Colors.green,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          titulo: 'Sistema SGC',
                          conteudo: Text(
                            widget.dados.chaveBloqueioRoteiro == '' ||
                                    widget.dados.chaveBloqueioRoteiro == null
                                ? 'Deseja bloquear futuras edições no roteiro atual?'
                                : 'Deseja desbloquear o roteiro atual?',
                          ),
                          tipo: Icones.pergunta,
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final roteiro = RoteiroEntrega();
                                int idRoteiro = int.parse(
                                  widget.dados.id.toString(),
                                );
                                if (widget.dados.chaveBloqueioRoteiro == '' ||
                                    widget.dados.chaveBloqueioRoteiro == null) {
                                  await roteiro.setStateRoteiro(
                                      idRoteiro, UserConstants().idLiberacao!);
                                  widget.dados.chaveBloqueioRoteiro =
                                      UserConstants().idLiberacao!;
                                } else {
                                  await roteiro.setStateRoteiro(idRoteiro, '');
                                  widget.dados.chaveBloqueioRoteiro = null;
                                }

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.of(context).pop();
                                });

                                setState(() {});
                              },
                              child: const Text('Sim'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Não'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
