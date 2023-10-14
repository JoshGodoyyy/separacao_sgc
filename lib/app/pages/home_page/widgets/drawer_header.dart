import 'package:flutter/material.dart';

import '../../../ui/styles/colors_app.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: ColorsApp.primaryColor),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: ColorsApp.backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sr. Rafinha',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
