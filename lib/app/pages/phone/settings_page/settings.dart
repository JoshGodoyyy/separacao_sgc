import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';
import 'package:sgc/app/pages/phone/settings_page/widgets/footer_embalagem.dart';
import 'package:sgc/app/pages/phone/settings_page/widgets/footer_separando.dart';
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

    return ListView(
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
              ToggleSwitch(
                label: 'Vidros',
                value: config.vidros,
                onChanged: () {
                  config.setVidros(!config.vidros);
                },
              ),
              ToggleSwitch(
                label: 'Chapas',
                value: config.chapas,
                onChanged: () {
                  config.setChapas(!config.chapas);
                },
              ),
              ToggleSwitch(
                label: 'Kits',
                value: config.kits,
                onChanged: () {
                  config.setKits(!config.kits);
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
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FooterSeparando(),
                  );
                },
              ),
              ToggleSwitch(
                label: 'Embalagem',
                value: config.embalagem,
                onChanged: () {
                  config.setEmbalagem(!config.embalagem);
                },
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FooterEmbalagem(),
                  );
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
          'Alerta',
          Column(
            children: [
              ToggleSwitch(
                label: 'Alerta para Retirar',
                value: config.retirar,
                onChanged: () {
                  config.setRetirar(!config.retirar);
                },
              ),
              ToggleSwitch(
                label: 'Alerta para Balcão',
                value: config.balcao,
                onChanged: () {
                  config.setBalcao(!config.balcao);
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
        group(
          context,
          'Impressão',
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  final ipController = TextEditingController();
                  final portController = TextEditingController();

                  ipController.text = config.printerIp;
                  portController.text = config.printerPort;

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
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
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'IP',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextField(
                                        controller: ipController,
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        'Porta',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextField(
                                        controller: portController,
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              config.setPrinterIp(
                                                ipController.text,
                                              );

                                              config.setPrinterPort(
                                                portController.text,
                                              );

                                              setState(() {});

                                              Navigator.pop(context);
                                            },
                                            child: const Text('Salvar'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Configurar impressora',
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
