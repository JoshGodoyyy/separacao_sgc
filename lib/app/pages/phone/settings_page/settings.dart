import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/ui/widgets/group.dart';

import '../../../ui/widgets/toggle_switch.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<AppConfig>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Configurações',
        ),
        centerTitle: true,
      ),
      body: ListView(
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
    );
  }
}
