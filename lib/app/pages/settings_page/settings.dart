import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/data/user.dart';
import 'package:sgc/app/pages/settings_page/widgets/group.dart';

import 'widgets/toggle_switch.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

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
            'Usuario',
            Column(
              children: [
                ListTile(
                  onTap: () {
                    showModal(
                      context,
                      'Nome',
                      'O nome será o mesmo utilizado para realizar o login na plataforma',
                      usuarioController,
                      () {},
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nome'),
                      Text(
                        User().userName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    showModal(
                      context,
                      'Senha',
                      'A senha será a mesma utilizada para realizar o login na plataforma',
                      senhaController,
                      () {},
                      true,
                    );
                  },
                  title: const Text('Senha'),
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Perfis',
                  value: config.profiles,
                  onChanged: () {
                    config.setProfiles(!config.profiles);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Acessórios',
                  value: config.accessories,
                  onChanged: () {
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
                const Divider(),
                ToggleSwitch(
                  label: 'Separando',
                  value: config.separando,
                  onChanged: () {
                    config.setSeparando(!config.separando);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Embalagem',
                  value: config.embalagem,
                  onChanged: () {
                    config.setEmbalagem(!config.embalagem);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Conferencia',
                  value: config.conferencia,
                  onChanged: () {
                    config.setConferencia(!config.conferencia);
                  },
                ),
                const Divider(),
                ToggleSwitch(
                  label: 'Faturar',
                  value: config.faturar,
                  onChanged: () {
                    config.setFaturar(!config.faturar);
                  },
                ),
                const Divider(),
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

  Future<dynamic> showModal(
    BuildContext context,
    String label,
    String info,
    TextEditingController controller,
    Function onTap, [
    bool obscureText = false,
  ]) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Alterar $label',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      info,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller,
                      obscureText: obscureText,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => onTap(),
                            child: const Text('Salvar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
