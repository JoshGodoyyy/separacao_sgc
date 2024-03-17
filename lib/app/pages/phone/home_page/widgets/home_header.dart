import 'package:flutter/material.dart';
import 'package:sgc/app/config/capitalize_text.dart';

import '../../../../config/user.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Olá, $user',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
