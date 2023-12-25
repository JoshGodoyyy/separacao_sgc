import 'package:flutter/material.dart';

import '../../../ui/styles/colors_app.dart';

class ListHeader extends StatelessWidget {
  final String label;
  const ListHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 5,
        color: ColorsApp.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
