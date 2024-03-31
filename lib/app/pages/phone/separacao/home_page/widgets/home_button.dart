import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgc/app/config/app_config.dart';

import '../../../../../ui/widgets/gradient_icon.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final int count;
  final double weight;
  final IconData icon;
  final Widget page;
  final Color begin;
  final Color end;
  final Function refresh;

  const HomeButton({
    super.key,
    required this.title,
    required this.count,
    required this.weight,
    required this.icon,
    required this.page,
    required this.begin,
    required this.end,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppConfig>(context);

    String formatValue(num value) {
      final formatter = NumberFormat('#,##0.00', 'pt_BR');
      return formatter.format(value);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        width: MediaQuery.of(context).size.width,
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
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (builder) => page),
                )
                .then((value) => refresh()),
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        color: Color(0xFF4951A2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: config.isDarkMode
                                ? Colors.white70
                                : Colors.white,
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
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  color: config.isDarkMode
                                      ? Colors.white54
                                      : Colors.black26,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 0.5,
                                  color: config.isDarkMode
                                      ? Colors.white54
                                      : Colors.black26,
                                ),
                              ),
                            ],
                          ),
                          Text('${formatValue(weight)} Kg'),
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
