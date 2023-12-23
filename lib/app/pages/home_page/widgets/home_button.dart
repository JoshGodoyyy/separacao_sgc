import 'package:flutter/material.dart';
import '/app/pages/home_page/widgets/gradient_icon.dart';
import '/app/ui/styles/colors_app.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Widget page;

  const HomeButton({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.page,
  });

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
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (builder) => page)),
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        color: Theme.of(context).indicatorColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          GradientIcon(
                            icon: icon,
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
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
