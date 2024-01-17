import 'package:flutter/material.dart';
import 'package:sgc/app/config/capitalize_text.dart';

import '../../../config/user.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
          ],
        ),
      ),
    );
  }
}
