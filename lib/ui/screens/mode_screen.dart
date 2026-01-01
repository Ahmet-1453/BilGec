import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';
import 'quiz_screen.dart';
import 'ai_topic_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context);

    return Scaffold(
      appBar: AppBar(title: Text(controller.selectedCategory?.name ?? "Kategori")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Ortaya hizaladık
          children: [
            // HAZIR TEST KARTI
            _buildModeCard(
              title: "Hazır Test Çöz", // Değişti
              subtitle: "Bu kategoriden seçilmiş soruları yanıtla.", // Değişti
              color: Colors.orange.shade100,
              borderColor: Colors.orange,
              onTap: () {
                controller.startReadyQuiz();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
              },
            ),
            const SizedBox(height: 20),
            // AI TEST KARTI
            _buildModeCard(
              title: "AI ile Soru Üret", // Değişti
              subtitle: "Yapay zeka senin için özel sorular hazırlasın.", // Değişti
              color: Colors.blue.shade100,
              borderColor: Colors.blue,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AiTopicScreen()));
              },
            ),
            // "Kalan üretim hakkı" yazısı silindi.
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard({required String title, required String subtitle, required Color color, required Color borderColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: borderColor.withRed(100))),
            ),
            const SizedBox(height: 15),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}