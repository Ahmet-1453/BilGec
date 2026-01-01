import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../state/quiz_controller.dart';
import '../widgets/category_tile.dart';
import 'mode_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(id: 'tarih', name: 'Tarih', color: const Color(0xFFFF7043), icon: Icons.history_edu),
    CategoryModel(id: 'cografya', name: 'Coğrafya', color: const Color(0xFF66BB6A), icon: Icons.public),
    CategoryModel(id: 'bilim_teknoloji', name: 'Bilim & Teknoloji', color: const Color(0xFF42A5F5), icon: Icons.science),
    CategoryModel(id: 'muzik', name: 'Müzik', color: const Color(0xFFAB47BC), icon: Icons.music_note),
    CategoryModel(id: 'film_sinema', name: 'Film & Sinema', color: const Color(0xFFEF5350), icon: Icons.movie),
    CategoryModel(id: 'spor', name: 'Spor', color: const Color(0xFFFFCA28), icon: Icons.sports_soccer),
    CategoryModel(id: 'edebiyat', name: 'Edebiyat', color: const Color(0xFF8D6E63), icon: Icons.book),
    CategoryModel(id: 'pop_kultur', name: 'Pop Kültür', color: const Color(0xFFEC407A), icon: Icons.star),
    CategoryModel(id: 'sanat', name: 'Sanat', color: const Color(0xFF7E57C2), icon: Icons.palette),
    CategoryModel(id: 'diger', name: 'Diğer', color: const Color(0xFF78909C), icon: Icons.category),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BilGeç", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu, color: Colors.indigo))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Kategoriler", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    category: categories[index],
                    onTap: () {
                      Provider.of<QuizController>(context, listen: false).selectCategory(categories[index]);
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