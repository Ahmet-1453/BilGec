import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryTile({
    super.key, 
    required this.category, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(30), 
          border: Border.all(color: Colors.black, width: 2.5), 
          boxShadow: const [
             BoxShadow(
               color: Colors.black, 
               offset: Offset(0, 4), 
               blurRadius: 0
             )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                   Container(
                     padding: const EdgeInsets.all(10),
                     decoration: const BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle
                     ),
                     child: Icon(category.icon, size: 28, color: Colors.black87),
                   ),
                   const SizedBox(width: 15),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           category.name, 
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87)
                         ),
                         const SizedBox(height: 4),
                         Text(
                           category.description, 
                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded, color: Colors.black87, size: 28),
          ],
        ),
      ),
    );
  }
}