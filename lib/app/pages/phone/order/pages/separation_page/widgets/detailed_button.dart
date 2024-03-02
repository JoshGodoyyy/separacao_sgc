import 'package:flutter/material.dart';
import 'package:sgc/app/ui/styles/colors_app.dart';

class DetailedButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String label;
  final bool isActive;

  const DetailedButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? ColorsApp.primaryColor : Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive ? Colors.white : null,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
