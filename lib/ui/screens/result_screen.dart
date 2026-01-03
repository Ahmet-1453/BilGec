import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Kullanıcı ismini almak için gerekli
import '../../state/quiz_controller.dart';
import 'home_screen.dart';
import 'mode_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context, listen: false);
  
    final user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName?.split(' ')[0] ?? "Dostum";

    int totalQuestions = controller.questions.length;
    int correctAnswers = controller.score ~/ 10; 
    double percentage = totalQuestions > 0 ? correctAnswers / totalQuestions : 0.0;
    
    String message;
    if (percentage >= 0.8) {
      message = "Efsanesin $userName!";
    } else if (percentage >= 0.5) {
      message = "Güzel İş $userName!";
    } else {
      message = "$userName, biraz daha çalışmalısın";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: percentage >= 0.5 ? Colors.green.shade50 : Colors.orange.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.thumb_up_rounded,
                        size: 60,
                        color: percentage >= 0.5 ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      "$correctAnswers / $totalQuestions",
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.black87),
                    ),
                    const Text("DOĞRU CEVAP", style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                    
                    const SizedBox(height: 30),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "+${controller.score} Puan Kazandın!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      message, 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: percentage >= 0.5 ? Colors.green.shade700 : Colors.orange.shade700)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      percentage >= 0.5 
                        ? "Harika gidiyorsun, bu başarınla gurur duyuyoruz."
                        : "Pes etmek yok, tekrar deneyerek başarabilirsin.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Başarı Oranı", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text("%${(percentage * 100).toInt()}", style: TextStyle(fontWeight: FontWeight.bold, color: percentage >= 0.5 ? Colors.green : Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: percentage,
                        minHeight: 15,
                        backgroundColor: Colors.grey.shade200,
                        color: percentage >= 0.5 ? Colors.orange : Colors.red, 
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (_) => const ModeScreen()),
                     );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Aynı Kategoriden Devam Et", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8F00), 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text("Ana Menüye Dön", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}