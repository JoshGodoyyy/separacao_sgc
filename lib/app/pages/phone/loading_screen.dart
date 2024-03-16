import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/data/repositories/pedido.dart';

import 'separacao/home_page/home_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getData();
  }

  Future<void> getData() async {
    final orders = Provider.of<Pedido>(context, listen: false);

    var navigator = Navigator.of(context);

    await orders.fetchData(2);
    await orders.fetchData(3);
    await orders.fetchData(5);
    await orders.fetchData(10);
    await orders.fetchData(14);
    await orders.fetchData(15);

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (builder) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xff12111F),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo_light.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            const SizedBox(height: 8),
            LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
