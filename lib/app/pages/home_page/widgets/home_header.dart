import 'package:flutter/material.dart';

import '../../../config/user.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String user = UserConstants().userName!;

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
