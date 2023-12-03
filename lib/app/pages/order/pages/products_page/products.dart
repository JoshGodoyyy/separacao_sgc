import 'package:flutter/material.dart';
import 'package:sgc/app/data/tratamento.dart';

import '../../../../data/pedidos.dart';
import '../../../../models/order_model.dart';
import '../treatment.dart';

class Products extends StatefulWidget {
  final Pedido pedido;
  const Products({
    super.key,
    required this.pedido,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late String tratamento;
  final tratamentoController = TextEditingController();
  bool visibility = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final pedido = await Pedidos().fetchOrdersByIdOrder(
      int.parse(
        widget.pedido.id.toString(),
      ),
    );

    if (pedido.tratamento == null || pedido.tratamento == '') {
      tratamento = '';
    } else {
      tratamento = pedido.tratamento!;

      final tratamentoInicial = await Tratamento().fetchTratamentoById(
        tratamento,
      );

      tratamentoController.text = tratamentoInicial.descricao.toString();
    }

    setState(() => _isVisible());
  }

  selecionarTratamento() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => Treatment(tratamento: tratamento),
      ),
    )
        .then(
      (value) async {
        if (value != null) {
          final result = await Tratamento().fetchTratamentoById(value);
          tratamentoController.text = result.descricao!;
        }
        setState(() {
          _isVisible();
        });
      },
    );
  }

  bool _isVisible() {
    if (tratamentoController.text == '') {
      visibility = false;
    } else {
      visibility = true;
    }

    return visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trat. quando utilizado Grupo Especial:',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Material(
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                    topRight: visibility
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomRight: visibility
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () => selecionarTratamento(),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      topRight: visibility
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                      bottomRight: visibility
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                    ),
                    child: TextField(
                      controller: tratamentoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_forward_ios_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visibility,
                child: Expanded(
                  child: Material(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    elevation: 5,
                    color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tratamentoController.clear();
                          visibility = false;
                        });
                      },
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
