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

    if (controller.questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = controller.questions[controller.currentIndex];
    const accent = Color(0xFF3F51B5);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Soru ${controller.currentIndex + 1} / ${controller.questions.length}",
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (controller.currentIndex + 1) / controller.questions.length,
                  minHeight: 8,
                  color: accent,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 500,

                  front: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: accent.withOpacity(0.12), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: accent.withOpacity(0.10)),
                              ),
                              child: Center(
                                child: Text(
                                  currentQuestion.question,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF2C3E50),
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          Expanded(
                            flex: 3,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemCount: currentQuestion.options.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      controller.checkAnswer(index);
                                      cardKey.currentState?.toggleCard();
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: accent.withOpacity(0.04),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: accent.withOpacity(0.18), width: 1.4),
                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))],
                                      ),
                                      child: Text(
                                        currentQuestion.options[index],
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  back: Container(
                    decoration: BoxDecoration(
                      color: controller.isLastAnswerCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 5))],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Icon(
                            controller.isLastAnswerCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                            color: controller.isLastAnswerCorrect ? Colors.green : Colors.red,
                            size: 80,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            controller.isLastAnswerCorrect ? "TEBRİKLER DOĞRU!" : "MAALESEF YANLIŞ!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: controller.isLastAnswerCorrect ? Colors.green.shade800 : Colors.red.shade800),
                          ),
                          const SizedBox(height: 30),
                          const Text("DOĞRU CEVAP", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3F51B5),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: const Color(0xFF3F51B5).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                            ),
                            child: Text(
                              currentQuestion.options[currentQuestion.correctIndex],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (currentQuestion.explanation.isNotEmpty)
                            Text(
                              currentQuestion.explanation,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF5252), foregroundColor: Colors.white, elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                              onPressed: () {
                                if (controller.currentIndex < controller.questions.length - 1) {
                                  cardKey.currentState?.toggleCard();
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    controller.nextQuestion();
                                  });
                                } else {
                                  controller.finishQuiz();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
                                }
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Text("Sonraki Soru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded)]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}