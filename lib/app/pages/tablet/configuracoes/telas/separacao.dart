import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';

import '../../../../ui/widgets/group.dart';
import '../../../../ui/widgets/toggle_switch.dart';

class ConfiguracoesSeparacao extends StatelessWidget {
  const ConfiguracoesSeparacao({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<AppConfig>(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            group(
              context,
              'Tipo de Produto',
              Column(
                children: [
                  ToggleSwitch(
                    label: 'Perfis',
                    value: config.profiles,
                    onChanged: () {
                      if (config.profiles && !config.accessories) {
                        config.setAccessories(true);
                      }
                      config.setProfiles(!config.profiles);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Acessórios',
                    value: config.accessories,
                    onChanged: () {
                      if (config.accessories && !config.profiles) {
                        config.setProfiles(true);
                      }
                      config.setAccessories(!config.accessories);
                    },
                  ),
                ],
              ),
            ),
            group(
              context,
              'Visualização',
              Column(
                children: [
                  ToggleSwitch(
                    label: 'Separar',
                    value: config.separar,
                    onChanged: () {
                      config.setSeparar(!config.separar);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Separando',
                    value: config.separando,
                    onChanged: () {
                      config.setSeparando(!config.separando);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Embalagem',
                    value: config.embalagem,
                    onChanged: () {
                      config.setEmbalagem(!config.embalagem);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Conferencia',
                    value: config.conferencia,
                    onChanged: () {
                      config.setConferencia(!config.conferencia);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Faturar',
                    value: config.faturar,
                    onChanged: () {
                      config.setFaturar(!config.faturar);
                    },
                  ),
                  ToggleSwitch(
                    label: 'Logística',
                    value: config.logistica,
                    onChanged: () {
                      config.setLogistica(!config.logistica);
                    },
                  ),
                ],
              ),
            ),
            group(
              context,
              'Tema',
              ToggleSwitch(
                label: 'Modo escuro',
                value: config.isDarkMode,
                onChanged: () {
                  config.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
