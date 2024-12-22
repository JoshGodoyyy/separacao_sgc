import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/conferencia_config.dart';

import '../../../../ui/widgets/toggle_switch.dart';

class FooterConferencia extends StatefulWidget {
  const FooterConferencia({super.key});

  @override
  State<FooterConferencia> createState() => _FooterConferenciaState();
}

class _FooterConferenciaState extends State<FooterConferencia> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConferenciaConfig>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ToggleSwitch(
              label: 'Embalagem',
              value: config.mostrarEmbalagem,
              onChanged: () => config.setEmbalagem(!config.mostrarEmbalagem),
            ),
            ToggleSwitch(
              label: 'Faturar',
              value: config.mostrarFaturar,
              onChanged: () => config.setFaturar(!config.mostrarFaturar),
            ),
            ToggleSwitch(
              label: 'Logística',
              value: config.mostrarLogistica,
              onChanged: () => config.setLogistica(!config.mostrarLogistica),
            ),
          ],
        ),
      ),
    );
  }
}
