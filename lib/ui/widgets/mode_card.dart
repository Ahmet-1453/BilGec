import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final VoidCallback onTap;

  const ModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color(0xFF1A237E);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: headerColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    border: const Border(
                      bottom: BorderSide(color: borderColor, width: 2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                     
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.chevron_right, color: Colors.grey, size: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}