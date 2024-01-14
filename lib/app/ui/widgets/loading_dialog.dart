import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/ui/widgets/custom_icons.dart';

import '../styles/colors_app.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 85,
                left: 16,
                right: 16,
              ),
              margin: const EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'SGC Mobile',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const Text('Atualizando informações',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 20),
                      LoadingAnimationWidget.inkDrop(
                        color: ColorsApp.secondaryColor,
                        size: 32,
                      ),
                      const SizedBox(width: 20),
                      const Text('Por favor, aguarde'),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              child: CustomIcon(
                tipo: Icones.info,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
