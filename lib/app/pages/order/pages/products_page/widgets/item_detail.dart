import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final String label;
  final Widget child;

  const ItemDetail({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Cor:',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
