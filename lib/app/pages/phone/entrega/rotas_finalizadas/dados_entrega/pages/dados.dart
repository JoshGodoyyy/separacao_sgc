import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_state.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../../ui/widgets/error_alert.dart';
import 'widgets/campo.dart';

class Dados extends StatefulWidget {
  final RoteiroEntregaModel roteiro;
  const Dados({
    super.key,
    required this.roteiro,
  });

  @override
  State<Dados> createState() => _DadosState();
}

class _DadosState extends State<Dados> {
  late RoteiroBloc _bloc;

  final horarioFormatter = DateFormat('HH:mm');
  final dataFormatter = DateFormat('dd/MM/yyyy HH:mm');

  final nomeMotoristaController = TextEditingController();
  final kmInicialController = TextEditingController();
  final kmFinalController = TextEditingController();
  final horaSaidaController = TextEditingController();
  final ajudanteController = TextEditingController();
  final placaController = TextEditingController();
  final pedagioController = TextEditingController();
  final combustivelController = TextEditingController();
  final refeicaoController = TextEditingController();
  final finalizacaoController = TextEditingController();
  final chegadaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = RoteiroBloc();
    _fetchData();
  }

  _fetchData() {
    _bloc.inputRoteiroController.add(
      GetRoteiro(
        idRoteiro: int.parse(
          widget.roteiro.id.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<RoteiroState>(
        stream: _bloc.outputRoteiroController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data is RoteiroLoadingState) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: LinearProgressIndicator(),
              ),
            );
          } else if (snapshot.data is RoteiroLoadedState) {
            RoteiroLoadedState data = snapshot.data as RoteiroLoadedState;

            nomeMotoristaController.text = data.roteiro!.nomeMotorista ?? '';
            kmInicialController.text = data.roteiro!.kmInicial.toString();
            kmFinalController.text = data.roteiro!.kmFinal.toString();
            combustivelController.text = data.roteiro!.combustivel.toString();
            pedagioController.text = data.roteiro!.pedagio.toString();
            refeicaoController.text = data.roteiro!.refeicao.toString();

            String chegada = horarioFormatter.format(
              DateTime.parse(
                data.roteiro!.horaChegada.toString(),
              ),
            );

            chegadaController.text = chegada;

            String finalizacao = dataFormatter.format(
              DateTime.parse(
                data.roteiro!.dataFinalizacao.toString(),
              ),
            );

            finalizacaoController.text = finalizacao;
            ajudanteController.text = data.roteiro!.ajudante ?? '';

            String horario = '';

            if (data.roteiro!.horaSaida != null) {
              horario = horarioFormatter.format(
                DateTime.parse(
                  data.roteiro!.horaSaida.toString(),
                ),
              );
            }
            horaSaidaController.text = horario;
            placaController.text = data.roteiro!.placa ?? '';
            return ListView(
              children: [
                Campo(
                  label: 'Motorista',
                  controller: nomeMotoristaController,
                  readOnly: true,
                  type: null,
                ),
                Campo(
                  label: 'Ajudante',
                  controller: ajudanteController,
                  readOnly: true,
                  type: null,
                ),
                Campo(
                  label: 'Placa',
                  controller: placaController,
                  readOnly: true,
                  type: null,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Km Inicial',
                        controller: kmInicialController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Km Final',
                        controller: kmFinalController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Combustível',
                        controller: combustivelController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Pedágio',
                        controller: pedagioController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Refeição',
                        controller: refeicaoController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Campo(
                        label: 'Chegada',
                        controller: chegadaController,
                        readOnly: true,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                  ],
                ),
                Campo(
                  label: 'Finalização',
                  controller: finalizacaoController,
                  readOnly: true,
                  type: const TextInputType.numberWithOptions(),
                ),
              ],
            );
          } else {
            return ErrorAlert(
              message: snapshot.error.toString(),
            );
          }
        },
      ),
    );
  }
}
