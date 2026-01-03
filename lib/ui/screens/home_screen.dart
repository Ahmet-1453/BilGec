import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';
import '../../models/category_model.dart';
import '../widgets/category_tile.dart';
import 'mode_screen.dart';
import 'profile_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context);
    
    final List<CategoryModel> categories = [
      CategoryModel(id: 'tarih', name: 'Tarih', description: 'GEÇMİŞİN İZLERİ', color: const Color(0xFFFFF59D), icon: Icons.history_edu),
      CategoryModel(id: 'cografya', name: 'Coğrafya', description: 'DÜNYA & YER', color: const Color(0xFF90CAF9), icon: Icons.public),
      CategoryModel(id: 'fen', name: 'Fen Bilimleri', description: 'DENEY & GÖZLEM', color: const Color(0xFFFFCC80), icon: Icons.science),
      CategoryModel(id: 'muzik', name: 'Müzik', description: 'RİTİM & AHENK', color: const Color(0xFFCE93D8), icon: Icons.music_note),
      CategoryModel(id: 'sinema', name: 'Filmler ve Sinema', description: 'BEYAZ PERDE', color: const Color(0xFFEF9A9A), icon: Icons.movie),
      CategoryModel(id: 'spor', name: 'Spor', description: 'REKABET & HEYECAN', color: const Color(0xFFFFF59D), icon: Icons.sports_soccer),
      CategoryModel(id: 'edebiyat', name: 'Edebiyat', description: 'KİTAP & ŞİİR', color: const Color(0xFFFFAB91), icon: Icons.book),
      CategoryModel(id: 'astronomi', name: 'Astronomi', description: 'GÖKYÜZÜ', color: const Color(0xFFB39DDB), icon: Icons.nights_stay),
      CategoryModel(id: 'sanat_kultur', name: 'Sanat & Kültür', description: 'ESTETİK', color: const Color(0xFF80CBC4), icon: Icons.palette),
      CategoryModel(id: 'mitoloji', name: 'Mitoloji', description: 'EFSANELER', color: const Color(0xFFE6EE9C), icon: Icons.auto_stories),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "BilGeç",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: -1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.indigo),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: const Text("KATEGORİNİ SEÇ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CategoryTile(
                    category: category,
                    onTap: () {
                      controller.selectCategory(category);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ModeScreen()),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}