import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_entregando/rotas_entregando.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_carregando/rotas_carregando.dart';
import 'package:sgc/app/pages/phone/entrega/rotas_finalizadas/rotas_finalizadas.dart';

import '../../../../data/enums/icones.dart';
import '../../../../ui/widgets/custom_dialog.dart';
import 'widgets/navigation_button.dart';

class RotasHome extends StatefulWidget {
  const RotasHome({super.key});

  @override
  State<RotasHome> createState() => _RotasHomeState();
}

class _RotasHomeState extends State<RotasHome> {
  late PageController _pageController;
  final _inicioController = TextEditingController();

  final DateFormat _data = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _tela = 0;

  final border = const BorderRadius.all(
    Radius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Scaffold(
        body: Column(
          children: [
            Material(
              color: Theme.of(context).primaryColor,
              borderRadius: border,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: border,
                  child: Row(
                    children: [
                      NavigationButton(
                        onTap: () {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Icons.indeterminate_check_box,
                        label: 'Carregando',
                        isActive: _tela == 0,
                      ),
                      NavigationButton(
                        onTap: () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Icons.route,
                        label: 'Entregando',
                        isActive: _tela == 1,
                      ),
                      NavigationButton(
                        onTap: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Icons.check_circle_outline_rounded,
                        label: 'Concluídas',
                        isActive: _tela == 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() => _tela = index);
                },
                children: [
                  RotasCarregando(
                    dataEntrega: _inicioController.text,
                  ),
                  const RotasEntregando(),
                  RotasFinalizadas(
                    dataEntrega: _inicioController.text,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: _tela != 1,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    titulo: 'Filtrar por Data',
                    conteudo: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selecionar data',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 5,
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: TextField(
                                  controller: _inicioController,
                                  readOnly: true,
                                  onTap: () async {
                                    final data = await _selectDate();
                                    setState(
                                      () => _inicioController.text =
                                          data != null
                                              ? _data.format(data)
                                              : '',
                                    );
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(
                                () => _inicioController.clear(),
                              ),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ],
                    ),
                    tipo: Icones.filtro,
                  );
                },
              );
            },
            child: const Icon(Icons.filter_alt),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    return picked;
  }
}
