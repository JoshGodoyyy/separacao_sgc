import 'package:flutter/material.dart';
import '../../../../ui/styles/colors_app.dart';

class Header extends StatelessWidget {
  final String label;
  const Header({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
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
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
