import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/menu_state.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
import 'package:sgc/app/pages/tablet/login_page/login_page.dart';
import 'package:sgc/app/ui/utils/notificacao.dart';
import 'app/config/app_config.dart';
import 'app/pages/phone/login_page/login_page.dart';
import '/app/ui/theme/theme_config.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificacaoService>(
          create: (context) => NotificacaoService(),
        ),
        ChangeNotifierProvider(
          create: (_) => Pedido(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppConfig(),
        ),
        ChangeNotifierProvider(
          create: (_) => MenuState(),
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
      home: MediaQuery.of(context).size.shortestSide >= 600
          ? const TLoginPage()
          : const LoginPage(),
      theme: context.watch<AppConfig>().isDarkMode
          ? ThemeConfig.darkTheme
          : ThemeConfig.theme,
    );
  }
}
