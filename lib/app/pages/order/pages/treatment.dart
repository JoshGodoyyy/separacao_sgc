import 'package:flutter/material.dart';
import 'package:sgc/app/models/tratamento.dart';
import 'package:sgc/app/pages/order/widgets/item.dart';

class Treatment extends StatefulWidget {
  final TratamentoModel? tratamento;
  const Treatment({
    super.key,
    this.tratamento,
  });

  @override
  State<Treatment> createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isVisible = widget.tratamento != null ? true : false;

    final descricao =
        widget.tratamento != null ? widget.tratamento!.descricao! : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Selecionar Tratamento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item(context, 'Pesquisar', searchController),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Visibility(
                visible: isVisible,
                child: Row(
                  children: [
                    const Text('Trat. Selec.:'),
                    const SizedBox(width: 24),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(descricao),
                              const Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
