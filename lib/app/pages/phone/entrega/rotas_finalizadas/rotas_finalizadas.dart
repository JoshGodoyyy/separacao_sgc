import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_finalizadas/dados_entrega/dados_entrega.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_finalizadas/widgets/pedido_entregue.dart';

import '../../../../data/blocs/roteiro_entrega/roteiro_bloc.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_event.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_state.dart';
import '../../../../ui/widgets/error_alert.dart';

class RotasFinalizadas extends StatefulWidget {
  final String dataEntrega;
  const RotasFinalizadas({super.key, required this.dataEntrega});

  @override
  State<RotasFinalizadas> createState() => _RotasFinalizadasState();
}

class _RotasFinalizadasState extends State<RotasFinalizadas> {
  late RoteiroBloc _roteiroBloc;
  bool carregando = false;

  final DateFormat _data = DateFormat('dd/MM/yyyy');

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
    var dataEntrega = widget.dataEntrega == ''
        ? DateTime.utc(0)
        : _data.parse(widget.dataEntrega);
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
            else if (roteiro.dataFinalizacao != null &&
                (DateTime.parse(roteiro.dataFinalizacao).isAfter(dataEntrega) ||
                    DateTime.parse(roteiro.dataFinalizacao)
                        .isAtSameMomentAs(dataEntrega)))
              PedidoEntregue(
                dados: roteiro,
                icon: Icons.info,
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
