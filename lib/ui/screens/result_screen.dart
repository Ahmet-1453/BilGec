import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context, listen: false);
    
    final int correctCount = (controller.score / 10).toInt(); 
    final int totalQuestions = 10;
    final int percentage = controller.score;

    String title;
    String message;
    Color themeColor;
    IconData statusIcon;

    if (percentage >= 80) {
      title = "Efsanesin!";
      message = "Konuya hakimsin, harika iş çıkardın.";
      themeColor = Colors.green.shade600;
      statusIcon = Icons.emoji_events_rounded;
    } else if (percentage >= 50) {
      title = "Güzel İş!";
      message = "Gayet iyisin ama biraz daha tekrarla mükemmel olabilir.";
      themeColor = Colors.orange.shade700;
      statusIcon = Icons.thumb_up_alt_rounded;
    } else {
      title = "Pes Etmek Yok!";
      message = "Biraz daha çalışman lazım, tekrar denemelisin.";
      themeColor = Colors.redAccent.shade400;
      statusIcon = Icons.psychology_alt_rounded;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                        ),
                        child: Icon(statusIcon, size: 70, color: Colors.white),
                      ),
                      
                      
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            
                            Text(
                              "$correctCount / $totalQuestions",
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                color: Colors.grey.shade800,
                                height: 1.0
                              ),
                            ),
                            Text(
                              "DOĞRU CEVAP",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 12
                              ),
                            ),
                            
                            const SizedBox(height: 30),

                            
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16, height: 1.4),
                            ),
                            
                            const SizedBox(height: 36),

                            
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Başarı Oranı", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    Text("%$percentage", style: TextStyle(fontWeight: FontWeight.bold, color: themeColor, fontSize: 18)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: LinearProgressIndicator(
                                    value: percentage / 100,
                                    minHeight: 16,
                                    backgroundColor: Colors.grey.shade100,
                                    color: themeColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

               
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 6,
                    shadowColor: themeColor.withOpacity(0.4),
                  ),
                  onPressed: () {
                    controller.resetQuiz();
                    Navigator.popUntil(context, (route) => route.isFirst); 
                  },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text("Ana Menüye Dön", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}