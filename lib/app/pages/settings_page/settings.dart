import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/widgets.dart';
import 'package:sgc/app/pages/settings_page/widgets/group.dart';

import '../../config/theme_provider.dart';
import 'widgets/toggle_switch.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool separarActive = false;
  bool separandoActive = false;
  bool embalagemActive = false;
  bool conferenciaActive = false;
  bool faturarActive = false;
  bool logisticaActive = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var widgets = Provider.of<Widgets>(context);

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
            'Visualização',
            Column(
              children: [
                ToggleSwitch(
                  label: 'Separar',
                  value: widgets.separar,
                  onChanged: () {
                    widgets.setSeparar(!widgets.separar);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Separando',
                  value: widgets.separando,
                  onChanged: () {
                    widgets.setSeparando(!widgets.separando);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Embalagem',
                  value: widgets.embalagem,
                  onChanged: () {
                    widgets.setEmbalagem(!widgets.embalagem);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Conferencia',
                  value: widgets.conferencia,
                  onChanged: () {
                    widgets.setConferencia(!widgets.conferencia);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Faturar',
                  value: widgets.faturar,
                  onChanged: () {
                    widgets.setFaturar(!widgets.faturar);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Logística',
                  value: widgets.logistica,
                  onChanged: () {
                    widgets.setLogistica(!widgets.logistica);
                  },
                ),
              ],
            ),
          ),
          group(
            context,
            'Tema',
            ToggleSwitch(
              label: 'Modo escuro:',
              value: themeProvider.currentTheme == ThemeMode.dark,
              onChanged: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
