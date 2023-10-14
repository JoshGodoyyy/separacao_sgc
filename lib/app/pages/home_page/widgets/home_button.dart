import 'package:flutter/material.dart';
import '/app/pages/home_page/widgets/gradient_icon.dart';
import '/app/ui/styles/colors_app.dart';

class HomeButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const HomeButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
          child: InkWell(
            onTap: () => widget.onTap(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GradientIcon(
                      icon: widget.icon,
                      size: 54,
                      gradient: const LinearGradient(
                        colors: [
                          ColorsApp.primaryColor,
                          ColorsApp.secondaryColor,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: ColorsApp.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
