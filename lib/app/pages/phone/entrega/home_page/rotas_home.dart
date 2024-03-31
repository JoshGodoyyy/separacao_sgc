import 'package:flutter/material.dart';
import 'package:sgc/app/pages/phone/entrega/home_page/screens/rotas_entregando.dart';
import 'package:sgc/app/pages/phone/entrega/home_page/screens/rotas_carregando.dart';

class RotasHome extends StatefulWidget {
  const RotasHome({super.key});

  @override
  State<RotasHome> createState() => _RotasHomeState();
}

class _RotasHomeState extends State<RotasHome> {
  final _telas = [
    const RotasCarregando(),
    const RotasEntregando(),
  ];

  final int _tela = 0;

  final border = const BorderRadius.all(
    Radius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
        //   child: Material(
        //     color: Theme.of(context).primaryColor,
        //     borderRadius: border,
        //     elevation: 5,
        //     child: Padding(
        //       padding: const EdgeInsets.all(6),
        //       child: ClipRRect(
        //         borderRadius: border,
        //         child: Row(
        //           children: [
        //             NavigationButton(
        //               onTap: () => setState(() => _tela = 0),
        //               icon: Icons.indeterminate_check_box,
        //               label: 'Carregando',
        //               isActive: _tela == 0,
        //             ),
        //             NavigationButton(
        //               onTap: () => setState(() => _tela = 1),
        //               icon: Icons.route,
        //               label: 'Entregando',
        //               isActive: _tela == 1,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          child: PageView(
            children: [
              _telas[_tela],
            ],
          ),
        ),
      ],
    );
  }
}
