import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/app/config/worker_function.dart';
import '/app/config/widgets.dart';
import '/app/config/theme_provider.dart';
import '/app/pages/login_page/login_page.dart';
import '/app/ui/theme/theme_config.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Widgets(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkerFunction(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
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
      theme: context.watch<ThemeProvider>().isDarkMode
          ? ThemeConfig.darkTheme
          : ThemeConfig.theme,
    );
  }
}
