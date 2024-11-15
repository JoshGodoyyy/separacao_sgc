import 'package:flutter/material.dart';
import 'package:sgc/app/config/api_config.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/models/url_api_model.dart';
import 'package:sgc/app/pages/initial_setup_page/widgets/url_modal.dart';
import 'package:sgc/app/ui/widgets/custom_dialog.dart';

import '../../ui/widgets/button.dart';

class InitialSetup extends StatefulWidget {
  const InitialSetup({super.key});

  @override
  State<InitialSetup> createState() => _InitialSetupState();
}

class _InitialSetupState extends State<InitialSetup> {
  final urlController = TextEditingController();

  final descricaoController = TextEditingController();
  final urlApiController = TextEditingController();

  List<UrlApiModel> _urls = [];

  String? _selectedItem;

  UrlApiModel? _url;

  @override
  void initState() {
    super.initState();
    _loadUrl();
  }

  _loadUrls() async {
    await ApiConfig().loadData();
    setState(() => _urls = ApiConfig().urls);
  }

  _loadUrl() async {
    await _loadUrls();

    if (_urls.isEmpty) return;

    _selectedItem = _urls.firstWhere((element) => element.padrao == true).url;

    setState(() {
      urlController.text = _selectedItem ?? '';
    });
  }

  _clearFields() {
    descricaoController.clear();
    urlApiController.clear();
  }

  _saveData() async {
    if (descricaoController.text == '' || urlApiController.text == '') return;

    var api = UrlApiModel(
      url: urlApiController.text,
      descricao: descricaoController.text,
      padrao: false,
    );

    if (_urls.any((item) => item.descricao == api.descricao)) {
      _clearFields();
      return;
    }

    _urls.add(api);

    await ApiConfig().saveData(_urls);

    _clearFields();
  }

  _editData() async {
    _urls.remove(_url);
    _saveData();
    _url = null;
  }

  _deleteData() async {
    _urls.remove(_url);
    await ApiConfig().saveData(_urls);
    _url = null;
  }

  _insertData(UrlApiModel api) async {
    _urls.insert(0, api);
    await ApiConfig().saveData(_urls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12111F),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logo_light.png',
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selecionar URL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownMenu(
                        initialSelection: _selectedItem,
                        expandedInsets: EdgeInsets.zero,
                        dropdownMenuEntries: _urls
                            .map(
                              (item) => DropdownMenuEntry(
                                value: item.url,
                                label: item.descricao,
                              ),
                            )
                            .toList(),
                        onSelected: (value) => setState(
                          () => _selectedItem = value!,
                        ),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    URLControlButton(
                      color: Colors.green,
                      icon: Icons.add,
                      onTap: () async {
                        await showModal(
                          context,
                          descricaoController,
                          urlApiController,
                          _saveData,
                        );
                        _loadUrls();
                      },
                    ),
                    const SizedBox(width: 8),
                    URLControlButton(
                      color: Colors.blue,
                      icon: Icons.edit,
                      enabled: _urls.isNotEmpty,
                      onTap: () async {
                        var item = _urls.firstWhere(
                          (_) => _.url == _selectedItem,
                        );

                        _url = item;
                        descricaoController.text = item.descricao;
                        urlApiController.text = item.url;

                        await showModal(
                          context,
                          descricaoController,
                          urlApiController,
                          _editData,
                        );

                        _loadUrls();

                        _selectedItem = item.url;
                      },
                    ),
                    const SizedBox(width: 8),
                    URLControlButton(
                      color: Colors.red,
                      icon: Icons.delete,
                      enabled: _urls.isNotEmpty,
                      onTap: () {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              titulo: 'Sistema SGC',
                              conteudo: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Deseja mesmo excluir este item?'),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          var item = _urls.firstWhere(
                                            (_) => _.url == _selectedItem,
                                          );

                                          _url = item;

                                          _deleteData();

                                          _loadUrls();

                                          Navigator.pop(context);

                                          setState(() {
                                            if (_urls.isNotEmpty) {
                                              _selectedItem = _urls.last.url;
                                            } else {
                                              _selectedItem = '';
                                            }
                                          });
                                        },
                                        child: const Text(
                                          'Sim',
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Não',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              tipo: Icones.pergunta,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Button(
                        label: 'Voltar',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Button(
                        label: 'Salvar',
                        onPressed: () async {
                          for (var url in _urls) {
                            url.padrao = false;
                          }

                          var item = _urls.firstWhere(
                            (_) => _.url == _selectedItem,
                          );

                          _urls.remove(item);

                          item.padrao = true;

                          _insertData(item);

                          urlApiController.text = _selectedItem ?? '';

                          await ApiConfig().setUrl(_selectedItem ?? '');

                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              Navigator.pop(context);
                            },
                          );
                        },
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
  }
}

class URLControlButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function onTap;
  final bool enabled;

  const URLControlButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? color : Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        onTap: () => enabled ? onTap() : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
