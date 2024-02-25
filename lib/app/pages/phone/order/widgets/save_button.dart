import 'package:flutter/material.dart';

import '../../../../ui/styles/colors_app.dart';

Padding saveButton(Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsApp.primaryColor,
        padding: const EdgeInsets.all(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.save),
          SizedBox(width: 4),
          Text('Salvar'),
        ],
      ),
    ),
  );
}
