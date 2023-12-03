import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/tratamento.dart';
import 'package:sgc/app/models/tratamento_model.dart';

class Treatment extends StatefulWidget {
  final String tratamento;
  const Treatment({
    super.key,
    required this.tratamento,
  });

  @override
  State<Treatment> createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
  late Future<List<TratamentoModel>> tratamentos;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tratamentos = Tratamento().fetchTratamento();
  }

  Future<String> tratamentoSelecionado(String value) async {
    final response = await Tratamento().fetchTratamentoById(value);
    return response.id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Selecionar Tratamento'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: tratamentos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TratamentoModel tratamento = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, tratamento.id);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            tratamento.descricao.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
