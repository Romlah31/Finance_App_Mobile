import 'package:flutter/material.dart';

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? bgColor;     
  final Color? iconColor;
  final Color? labelColor;  
  final VoidCallback? onTap;

  const GridMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.bgColor,
    this.iconColor,
    this.labelColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (bgColor ?? Colors.deepPurple.shade50).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36,
            color: iconColor ?? Colors.deepPurple,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: labelColor ?? Colors.white,   
            ),
          ),
        ],
      ),
    );
  }
}
