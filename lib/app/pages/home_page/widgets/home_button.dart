import 'package:flutter/material.dart';
import '/app/pages/home_page/widgets/gradient_icon.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Widget page;
  final Color begin;
  final Color end;

  const HomeButton({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.page,
    required this.begin,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: begin,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(20),
            ),
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => page),
              ),
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
                              gradient: LinearGradient(
                                colors: [
                                  begin,
                                  end,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
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
      ),
    );
  }
}
