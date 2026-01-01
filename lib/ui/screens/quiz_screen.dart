import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import '../../state/quiz_controller.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context);
    
    if (controller.questions.isEmpty) return const Scaffold(body: Center(child: Text("Soru Yok")));

    final currentQuestion = controller.questions[controller.currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Soru ${controller.currentIndex + 1} / 10")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (controller.currentIndex + 1) / 10,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
              color: Colors.indigo,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),

            Expanded(
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false, 
                front: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              currentQuestion.questionText,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        
                        ...List.generate(4, (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              minimumSize: const Size(double.infinity, 50),
                              alignment: Alignment.centerLeft,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.indigo)),
                            ),
                            onPressed: () {
                              
                              controller.checkAnswer(index);
                              
                              cardKey.currentState?.toggleCard();
                            },
                            child: Text("${String.fromCharCode(65 + index)}) ${currentQuestion.options[index]}"),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                
                back: Card(
                  color: controller.isLastAnswerCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.isLastAnswerCorrect ? "TEBRİKLER DOĞRU!" : "MAALESEF YANLIŞ",
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold, 
                            color: controller.isLastAnswerCorrect ? Colors.green : Colors.red
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("Doğru Cevap:", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            currentQuestion.options[currentQuestion.correctIndex],
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(currentQuestion.explanation, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent, // Dikkat çekmesi için Kırmızı yaptım
                            foregroundColor: Colors.white, 
                            minimumSize: const Size(double.infinity, 50)
                          ),
                          onPressed: () {
                            if (controller.currentIndex < 9) {
                              // Önce kartı ön yüze çevir
                              cardKey.currentState?.toggleCard();
                              
                              // Kart dönerken soruyu değiştir (küçük bir gecikme ile)
                              Future.delayed(const Duration(milliseconds: 200), () {
                                controller.nextQuestion();
                              });
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
                            }
                          },
                          child: const Text("Sonraki Soru"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}