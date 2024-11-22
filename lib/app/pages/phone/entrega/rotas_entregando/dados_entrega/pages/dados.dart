import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_state.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

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

  final nomeMotoristaController = TextEditingController();
  final kmInicialController = TextEditingController();
  final horaSaidaController = TextEditingController();
  final ajudanteController = TextEditingController();
  final placaController = TextEditingController();

  String horario = '';

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
            ajudanteController.text = data.roteiro!.ajudante ?? '';
            horaSaidaController.text = horarioFormatter.format(
              DateTime.parse(data.roteiro!.horaSaida ?? '00:00'),
            );
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
                  readOnly: false,
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
                        readOnly: false,
                        type: const TextInputType.numberWithOptions(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: HorarioSaida(
                          horaSaidaController: horaSaidaController,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (horaSaidaController.text == '') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              titulo: 'Atenção',
                              conteudo: const Text(
                                'Você deve informar o horário de saída',
                                textAlign: TextAlign.center,
                              ),
                              tipo: Icones.info,
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
                        double value = double.parse(kmInicialController.text);

                        var data =
                            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${horaSaidaController.text}';

                        _bloc.inputRoteiroController.add(
                          UpdateDados(
                            idRoteiro: int.parse(
                              widget.roteiro.id.toString(),
                            ),
                            kmInicial: value,
                            ajudante: ajudanteController.text,
                            horarioSaida: data,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.primaryColor),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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

class HorarioSaida extends StatefulWidget {
  const HorarioSaida({
    super.key,
    required this.horaSaidaController,
  });

  final TextEditingController horaSaidaController;

  @override
  State<HorarioSaida> createState() => _HorarioSaidaState();
}

class _HorarioSaidaState extends State<HorarioSaida> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Horário de Saída',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Material(
          elevation: 5,
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: InkWell(
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (time != null) {
                var minute = time.minute;
                String value =
                    '${time.hour}:${minute.toString().padLeft(2, '0')}';

                setState(() {
                  widget.horaSaidaController.text = value;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Text(widget.horaSaidaController.text),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
