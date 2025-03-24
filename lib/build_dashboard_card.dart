import 'package:flutter/material.dart';

// ignore: camel_case_types
class buildDashboardCard extends StatelessWidget {
  const buildDashboardCard({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });

  final BuildContext context;
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Container(
          width: 170,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
