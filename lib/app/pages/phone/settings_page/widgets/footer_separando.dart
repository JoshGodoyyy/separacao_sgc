import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/separando_config.dart';
import 'package:sgc/app/ui/widgets/toggle_switch.dart';

class FooterSeparando extends StatefulWidget {
  const FooterSeparando({super.key});

  @override
  State<FooterSeparando> createState() => _FooterSeparandoState();
}

class _FooterSeparandoState extends State<FooterSeparando> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<SeparandoConfig>(context);

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
              label: 'Conferência',
              value: config.mostrarConferencia,
              onChanged: () =>
                  config.setConferencia(!config.mostrarConferencia),
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
