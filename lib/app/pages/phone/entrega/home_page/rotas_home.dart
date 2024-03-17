import 'package:flutter/material.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';
import 'package:sgc/app/pages/phone/entrega/cliente_page/clientes.dart';
import 'package:sgc/app/pages/phone/entrega/home_page/widgets/rota_button.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

class RotasHome extends StatefulWidget {
  const RotasHome({super.key});

  @override
  State<RotasHome> createState() => _RotasHomeState();
}

class _RotasHomeState extends State<RotasHome> {
  @override
  Widget build(BuildContext context) {
    var rota1 = RoteiroEntregaModel(
      nome: 'Rota 01',
      dataCriacao: '16/03/2024 17:19',
      dataEntrega: '20/03/2024',
      motorista: 'Raphael Rodrigues',
      placa: 'EGL7H00',
      peso: 7804,
      valorTotal: 5380,
      totalClientes: 10,
      totalPedidos: 20,
    );

    var rota2 = RoteiroEntregaModel(
      nome: 'Rota 02',
      dataCriacao: '05/11/2023 08:15',
      dataEntrega: '10/11/2023',
      motorista: 'Carlos Santos',
      placa: 'DEF9012',
      peso: 10850,
      valorTotal: 15680,
      totalClientes: 7,
      totalPedidos: 15,
    );

    var rota3 = RoteiroEntregaModel(
      nome: 'Rota 03',
      dataCriacao: '12/07/2023 14:27',
      dataEntrega: '18/07/2023',
      motorista: 'Maria Oliveira',
      placa: 'XYZ5678',
      peso: 1506,
      valorTotal: 3220,
      totalClientes: 9,
      totalPedidos: 9,
    );
    return RefreshIndicator(
      onRefresh: () async {},
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Material(
                    elevation: 5,
                    color: ColorsApp.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Não Finalizadas',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                RotaButton(
                  dados: rota1,
                  icon: Icons.roundabout_right_outlined,
                  page: Clientes(
                    dados: rota1,
                  ),
                  begin: Colors.green,
                  end: Colors.greenAccent,
                  refresh: () {},
                ),
                RotaButton(
                  dados: rota3,
                  icon: Icons.roundabout_right_outlined,
                  page: Clientes(
                    dados: rota3,
                  ),
                  begin: Colors.green,
                  end: Colors.greenAccent,
                  refresh: () {},
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Material(
                    elevation: 5,
                    color: ColorsApp.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Finalizadas',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                RotaButton(
                  dados: rota2,
                  icon: Icons.roundabout_right_outlined,
                  page: Clientes(
                    dados: rota2,
                  ),
                  begin: Colors.green,
                  end: Colors.greenAccent,
                  refresh: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
