import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'app/config/app_config.dart';
import '/app/pages/login_page/login_page.dart';
import '/app/ui/theme/theme_config.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Pedido(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppConfig(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: context.watch<AppConfig>().isDarkMode
          ? ThemeConfig.darkTheme
          : ThemeConfig.theme,
    );
  }
}
