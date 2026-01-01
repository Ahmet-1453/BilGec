import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}