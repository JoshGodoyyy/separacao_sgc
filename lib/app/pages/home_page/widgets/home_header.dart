import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/config/capitalize_text.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

import '../../../config/user.dart';

class HomeHeader extends StatefulWidget {
  final bool carregando;
  const HomeHeader({
    super.key,
    required this.carregando,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    String user = CapitalizeText.capitalizeFirstLetter(
      UserConstants().userName!.split(' ')[0].toLowerCase(),
    );

    return Material(
      elevation: 5,
      color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Olá, $user',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Visibility(
              visible: widget.carregando,
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorsApp.secondaryColor,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
