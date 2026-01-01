import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context, listen: false);
    
    String level = "Başlangıç";
    Color levelColor = Colors.orange;
    if (controller.score >= 80) { level = "İleri"; levelColor = Colors.green; }
    else if (controller.score >= 50) { level = "Orta"; levelColor = Colors.blue; }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sonuç", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("Tebrikler!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.indigo)),
              const SizedBox(height: 10),
              Text("${controller.score / 10} / 10", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(color: levelColor, borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Text("%${controller.score}", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("$level Seviyesi", style: const TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, minimumSize: const Size(200, 50)),
                onPressed: () {
                  controller.resetQuiz();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Tekrar Çöz"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  controller.resetQuiz();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Ana Sayfa"),
              )
            ],
          ),
        ),
      ),
    );
  }
}