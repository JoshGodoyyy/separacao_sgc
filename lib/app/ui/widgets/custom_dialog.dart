import 'package:flutter/material.dart';
import 'package:sgc/app/data/enums/icones.dart';
import 'package:sgc/app/ui/widgets/custom_icons.dart';

class CustomDialog extends StatelessWidget {
  final String titulo, descricao;
  final Icones tipo;
  const CustomDialog({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.tipo,
  });

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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      titulo,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  Text(descricao, textAlign: TextAlign.center),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: CustomIcon(
                tipo: tipo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
