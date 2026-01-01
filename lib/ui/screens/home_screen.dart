import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../state/quiz_controller.dart';
import '../widgets/category_tile.dart';
import 'quiz_screen.dart';
import 'ai_topic_screen.dart';

// --- 1. MODERN GİRİŞ EKRANI (ANA SAYFA) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "BilGeç", 
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        // Hamburger menü kaldırıldı (actions kısmı silindi)
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Hoş Geldin!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800),
                ),
                Text(
                  "Bugün nasıl yarışmak istersin?",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade600),
                ),
                const SizedBox(height: 40),

                // KART 1: HAZIR SORULAR
                _buildGameModeCard(
                  context: context,
                  title: "Hazır Test Çöz",
                  subtitle: "Kategorini seç, soruları yanıtla.",
                  icon: Icons.library_books_rounded,
                  color1: Colors.blue.shade400,
                  color2: Colors.indigo.shade600,
                  onTap: () {
                    // Kategori seçimine yönlendir
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CategorySelectionScreen()));
                  },
                ),

                const SizedBox(height: 20),

                // KART 2: AI SORU OLUŞTUR
                _buildGameModeCard(
                  context: context,
                  title: "AI ile Test Üret",
                  subtitle: "Yapay zeka sana özel sorular hazırlasın.",
                  icon: Icons.psychology_rounded,
                  color1: Colors.purple.shade400,
                  color2: Colors.deepPurple.shade600,
                  onTap: () {
                    // AI Ekranına yönlendir
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AiTopicScreen()));
                  },
                ),
                
                const Spacer(),
                Center(child: Text("v1.0.0", style: TextStyle(color: Colors.grey.shade400))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: color1.withOpacity(0.3),
        child: Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1, color2],
            ),
            boxShadow: [
              BoxShadow(
                color: color2.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: Icon(icon, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.6), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. KATEGORİ SEÇİM EKRANI (Hazır Teste Basınca Burası Açılır) ---
class CategorySelectionScreen extends StatelessWidget {
  CategorySelectionScreen({super.key});

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
    CategoryModel(id: 'genel_kultur', name: 'Genel Kültür', color: const Color(0xFF607D8B), icon: Icons.psychology),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Kategori Seç", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5, // Dikdörtgen görünüm
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return CategoryTile(
                    category: cat,
                    onTap: () {
                      // Seçim yapınca direkt teste başla
                      Provider.of<QuizController>(context, listen: false).selectCategory(cat);
                      Provider.of<QuizController>(context, listen: false).startReadyQuiz();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
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