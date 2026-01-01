import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final String subtitle;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.category,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: category.color,
            borderRadius: BorderRadius.circular(50), 
            border: Border.all(
              color: Colors.black, 
              width: 2.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black, 
                offset: Offset(0, 5),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    category.icon,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900, // Çok kalın yazı
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 30,
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