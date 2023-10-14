import 'package:flutter/material.dart';

import '/app/pages/login_page/login_page.dart';
import '/app/ui/theme/theme_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeConfig.theme,
    );
  }
}
