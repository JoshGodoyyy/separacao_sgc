import 'package:flutter/material.dart';
import 'package:sgc/app/pages/phone/settings_page/settings.dart';

import '../../../../../ui/styles/colors_app.dart';
import '../../../../../ui/widgets/gradient_icon.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => const Settings(),
                ),
              );
            },
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GradientIcon(
                      icon: Icons.settings,
                      size: 54,
                      gradient: LinearGradient(
                        colors: [
                          ColorsApp.primaryColor,
                          ColorsApp.secondaryColor,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Configurações',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
