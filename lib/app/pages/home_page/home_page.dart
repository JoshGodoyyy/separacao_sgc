import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff12111F),
          selectedItemColor: const Color(0xFF5acce8),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Separar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Separando',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Embalagem',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Conferência',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Faturar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Logística',
            ),
          ],
        ),
      ),
    );
  }
}
