import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  final Uint8List imagem;
  final String label;
  const ProductImage({
    super.key,
    required this.imagem,
    required this.label,
  });

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
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
              widget.label,
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
              child: Image.memory(widget.imagem),
            ),
          ),
        ],
      ),
    );
  }
}
