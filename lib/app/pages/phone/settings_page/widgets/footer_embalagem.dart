import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/embalagem_config.dart';

import '../../../../ui/widgets/toggle_switch.dart';

class FooterEmbalagem extends StatefulWidget {
  const FooterEmbalagem({super.key});

  @override
  State<FooterEmbalagem> createState() => _FooterEmbalagemState();
}

class _FooterEmbalagemState extends State<FooterEmbalagem> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<EmbalagemConfig>(context);

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
              label: 'Conferência',
              value: config.mostrarConferencia,
              onChanged: () => config.setEmbalagem(!config.mostrarConferencia),
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
