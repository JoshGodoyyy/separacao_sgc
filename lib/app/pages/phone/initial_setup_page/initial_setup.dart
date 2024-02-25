import 'package:flutter/material.dart';
import 'package:sgc/app/config/api_config.dart';

import '../../../ui/widgets/button.dart';
import '../../../ui/widgets/textfield.dart';

class InitialSetup extends StatefulWidget {
  const InitialSetup({super.key});

  @override
  State<InitialSetup> createState() => _InitialSetupState();
}

class _InitialSetupState extends State<InitialSetup> {
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUrl();
  }

  _loadUrl() async {
    await ApiConfig().getUrl();
    setState(() {
      urlController.text = ApiConfig().url;
    });
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
                STextField(
                  controller: urlController,
                  label: 'URL',
                  usePasswordChar: false,
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
                        onPressed: () {
                          ApiConfig().setUrl(urlController.text);
                          Navigator.pop(context);
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
