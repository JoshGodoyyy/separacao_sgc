import 'package:flutter/material.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_entregando/dados_entrega/dados_entrega.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_entregando/widgets/pedido_entregando.dart';

import '../../../../data/blocs/roteiro_entrega/roteiro_bloc.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_event.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_state.dart';
import '../../../../ui/widgets/error_alert.dart';

class RotasEntregando extends StatefulWidget {
  const RotasEntregando({super.key});

  @override
  State<RotasEntregando> createState() => _RotasEntregandoState();
}

class _RotasEntregandoState extends State<RotasEntregando> {
  late RoteiroBloc _roteiroBloc;
  bool carregando = false;

  List roteiros = [];

  @override
  void initState() {
    super.initState();
    _roteiroBloc = RoteiroBloc();
    _fetchRoteiros();
  }

  _fetchRoteiros() {
    setState(() => carregando = true);
    _roteiroBloc.inputRoteiroController.add(
      GetRoteiros(),
    );
    setState(() => carregando = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Padding _roteiros(List data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: [
          for (var roteiro in data)
            if (data.isEmpty)
              const Center(
                child: Text(
                  'Nada por aqui',
                  style: TextStyle(fontSize: 24),
                ),
              )
            else if (roteiro.carregamentoConcluido == 1 &&
                roteiro.dataFinalizacao == null)
              PedidoEntregando(
                dados: roteiro,
                icon: Icons.local_shipping_rounded,
                page: DadosEntrega(
                  roteiro: roteiro,
                ),
                begin: Colors.blue,
                end: Colors.blue[300]!,
                bloc: _roteiroBloc,
              )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RoteiroState>(
      stream: _roteiroBloc.outputRoteiroController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data is RoteiroLoadingState) {
          return Stack(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  child: LinearProgressIndicator(),
                ),
              ),
              _roteiros(roteiros),
            ],
          );
        } else if (snapshot.data is RoteiroLoadedState) {
          roteiros = snapshot.data?.roteiros ?? [];
          return RefreshIndicator(
            onRefresh: () async {
              _fetchRoteiros();
            },
            child: _roteiros(roteiros),
          );
        } else {
          return ErrorAlert(
            message: snapshot.error.toString(),
          );
        }
      },
    );
  }
}
