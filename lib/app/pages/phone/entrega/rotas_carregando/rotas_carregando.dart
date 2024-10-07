import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_bloc.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_event.dart';
import '../../../../data/blocs/roteiro_entrega/roteiro_state.dart';
import '../../../../ui/widgets/error_alert.dart';
import 'cliente_page/clientes.dart';
import 'widgets/rota_button.dart';

class RotasCarregando extends StatefulWidget {
  final String dataEntrega;

  const RotasCarregando({super.key, required this.dataEntrega});

  @override
  State<RotasCarregando> createState() => _RotasCarregandoState();
}

class _RotasCarregandoState extends State<RotasCarregando> {
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
          for (var roteiro in data.where((item) =>
              item.carregamentoConcluido == 0 &&
              (DateTime.parse(item.dataEntrega).isAfter(dataEntrega) ||
                  DateTime.parse(item.dataEntrega)
                      .isAtSameMomentAs(dataEntrega))))
            RotaButton(
              dados: roteiro,
              icon: Icons.roundabout_right_outlined,
              page: Clientes(
                dados: roteiro,
                bloc: _roteiroBloc,
              ),
              begin: Colors.green,
              end: Colors.greenAccent,
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
