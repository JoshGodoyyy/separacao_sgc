import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String label;
  const ProductImage({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              label,
              style: const TextStyle(
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
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
