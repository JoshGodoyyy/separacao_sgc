import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/pedidos.dart';
import '../../models/order_model.dart';
import 'widgets/list_item.dart';

class MainPage extends StatefulWidget {
  final String title;
  final int status;
  final IconData icon;

  const MainPage({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Pedido>> pedidos;

  @override
  void initState() {
    super.initState();
    pedidos = Pedidos().fetchOrdersBySituation(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: pedidos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Pedido pedido = snapshot.data![index];
                return ListItem(icon: widget.icon, pedido: pedido);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
