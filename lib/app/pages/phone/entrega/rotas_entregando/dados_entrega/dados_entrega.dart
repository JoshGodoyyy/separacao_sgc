import 'package:flutter/material.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_bloc.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import 'package:sgc/app/models/endereco_roteiro_entrega_model.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../../../../ui/widgets/error_alert.dart';

class DadosEntrega extends StatefulWidget {
  final RoteiroEntregaModel roteiro;
  const DadosEntrega({
    super.key,
    required this.roteiro,
  });

  @override
  State<DadosEntrega> createState() => _DadosEntregaState();
}

class _DadosEntregaState extends State<DadosEntrega> {
  late EnderecoRoteiroBloc _bloc;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _bloc = EnderecoRoteiroBloc();
    _fetchData();
  }

  _fetchData() {
    _bloc.inputRoteiroEntregaController.add(
      GetEnderecosRoteiro(
        idRoteiro: int.parse(
          widget.roteiro.id.toString(),
        ),
      ),
    );
  }

  String endereco(EnderecoRoteiroEntregaModel data) {
    if (data.endereco == null) {
      return '';
    } else {
      if (data.complemento != '') {
        return '${data.logradouro} ${data.endereco}, ${data.numero} - ${data.complemento} - ${data.bairro} - ${data.cidade} - ${data.estado} - ${data.cep}.';
      } else {
        return '${data.logradouro} ${data.endereco}, ${data.numero} - ${data.bairro} - ${data.cidade} - ${data.estado} - ${data.cep}.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roteiro.nome ?? ''),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder<EnderecoRoteiroState>(
        stream: _bloc.outputRoteiroEntregaController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data is EnderecoRoteiroLoadingState) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: LinearProgressIndicator(),
              ),
            );
          } else if (snapshot.data is EnderecoRoteiroLoadedState) {
            List enderecos = snapshot.data?.enderecos ?? [];

            if (enderecos.isEmpty) {
              return const Center(
                child: Text('Nada por aqui 👀'),
              );
            } else {
              return Stepper(
                currentStep: _currentStep,
                onStepTapped: (value) {
                  setState(() => _currentStep = value);
                },
                steps: [
                  for (var item in enderecos)
                    Step(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          endereco(item),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(item.fantasia ?? ''),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          elevation: 5,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: SizedBox(
                              child: Text('Pedido ${item.id}'),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              );
            }
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
