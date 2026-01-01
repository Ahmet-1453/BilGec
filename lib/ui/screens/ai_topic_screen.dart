import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';
import '../widgets/loading_panel.dart';
import 'quiz_screen.dart';

class AiTopicScreen extends StatefulWidget {
  const AiTopicScreen({super.key});

  @override
  State<AiTopicScreen> createState() => _AiTopicScreenState();
}

class _AiTopicScreenState extends State<AiTopicScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizController>(context);

    if (quizController.isLoading) {
      return const Scaffold(body: LoadingPanel(message: "AI soru üretiyor...\nLütfen bekleyin..."));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("AI ile Test Üret")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100, width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Icon(Icons.auto_awesome, size: 50, color: Colors.purple),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Hangi konuda soru üretilsin?",
                border: OutlineInputBorder(),
                filled: true, fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  await quizController.startAiQuizPlaceholder(_controller.text);
                  if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                }
              },
              child: const Text("Testi Üret"),
            )
          ],
        ),
      ),
    );
  }
}