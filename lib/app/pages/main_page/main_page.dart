import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sgc/app/pages/main_page/widgets/error_alert.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';
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
  final searchController = TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Pesquisar',
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 5,
                  color: ColorsApp.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
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
                  return ErrorAlert(
                    message: '${snapshot.error}',
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
          ),
        ],
      ),
    );
  }
}
