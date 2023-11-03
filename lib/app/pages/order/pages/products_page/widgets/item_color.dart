import 'package:flutter/material.dart';
import 'package:sgc/app/models/colors.dart';

class ItemColor extends StatelessWidget {
  final Cor cor;
  const ItemColor({
    super.key,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cor.cor,
      ),
      width: 18,
      height: 18,
    );
  }
}
