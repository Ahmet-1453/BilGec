import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../state/quiz_controller.dart';
import '../widgets/category_tile.dart';
import 'mode_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(id: 'tarih', name: 'Tarih', color: const Color(0xFFFFF59D), icon: Icons.history_edu),
    CategoryModel(id: 'cografya', name: 'Coğrafya', color: const Color(0xFF90CAF9), icon: Icons.public),
    CategoryModel(id: 'fen_bilimleri', name: 'Fen Bilimleri', color: const Color(0xFFFFCC80), icon: Icons.science),
    CategoryModel(id: 'muzik', name: 'Müzik', color: const Color(0xFFB39DDB), icon: Icons.music_note),
    CategoryModel(id: 'film_sinema', name: 'Filmler ve Sinema', color: const Color(0xFFEF9A9A), icon: Icons.movie),
    CategoryModel(id: 'spor', name: 'Spor', color: const Color(0xFFFFF176), icon: Icons.sports_soccer),
    CategoryModel(id: 'edebiyat', name: 'Edebiyat', color: const Color(0xFFFFAB91), icon: Icons.menu_book),
    CategoryModel(id: 'astronomi', name: 'Astronomi', color: const Color(0xFF9FA8DA), icon: Icons.auto_awesome),
    CategoryModel(id: 'sanat_kultur', name: 'Sanat ve Kültür', color: const Color(0xFFA5D6A7), icon: Icons.palette),
    CategoryModel(id: 'mitoloji', name: 'Mitoloji', color: const Color(0xFFCE93D8), icon: Icons.account_balance),
  ];

  String _getSubtitle(String id) {
    switch (id) {
      case 'tarih': return "GEÇMİŞİN İZLERİ";
      case 'cografya': return "DÜNYA & YER";
      case 'fen_bilimleri': return "DENEY & GÖZLEM";
      case 'muzik': return "RİTİM & AHENK";
      case 'film_sinema': return "BEYAZ PERDE";
      case 'spor': return "GÜÇ & HAREKET";
      case 'edebiyat': return "SÖZÜN GÜCÜ";
      case 'astronomi': return "UZAY & EVREN";
      case 'sanat_kultur': return "RENK & BİÇİM";
      case 'mitoloji': return "EFSANELER";
      default: return "GENEL KÜLTÜR";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- HEADER ---
            const Text(
              "BilGeç",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -1.5,
              ),
            ),
            
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Text(
                "KATEGORİNİ SEÇ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryTile(
                    category: category,
                    subtitle: _getSubtitle(category.id),
                    onTap: () {
                      Provider.of<QuizController>(context, listen: false).selectCategory(category);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ModeScreen()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}