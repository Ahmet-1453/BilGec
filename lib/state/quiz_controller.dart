import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../data/ready_question_bank.dart';

class QuizController extends ChangeNotifier {
  CategoryModel? selectedCategory;
  List<QuestionModel> questions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = false;
  String errorMessage = '';
  bool isLastAnswerCorrect = false; // ADIM 3: Son cevap durumu eklendi

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }

  void startReadyQuiz() {
    isLoading = true;
    errorMessage = '';
    score = 0;
    currentIndex = 0;
    questions = [];
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (selectedCategory != null) {
        List<QuestionModel> pool = readyQuestions
            .where((q) => q.categoryId == selectedCategory!.id)
            .toList();

        if (pool.isEmpty) {
          pool.add(QuestionModel(
            categoryId: selectedCategory!.id,
            questionText: "${selectedCategory!.name} hakkında örnek soru.",
            options: ["A", "B", "C", "D"],
            correctIndex: 0,
            explanation: "Bu bir yedek sorudur.",
          ));
        }

        List<QuestionModel> finalQuestions = [];
        while (finalQuestions.length < 10) {
          pool.shuffle();
          finalQuestions.addAll(pool);
        }

        questions = finalQuestions.sublist(0, 10);
      }
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> startAiQuizPlaceholder(String topic) async {
    isLoading = true;
    score = 0;
    currentIndex = 0;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));

    questions = List.generate(10, (index) => QuestionModel(
      categoryId: 'ai',
      questionText: '$topic hakkında yapay zeka sorusu #${index + 1}',
      options: ['A Şıkkı', 'B Şıkkı', 'C Şıkkı', 'D Şıkkı'],
      correctIndex: 0,
      explanation: 'Bu soru Gemini API entegrasyonu tamamlanınca gerçek olacak.',
    ));

    isLoading = false;
    notifyListeners();
  }

  void checkAnswer(int selectedIndex) {
    if (questions.isEmpty) return;

    if (selectedIndex == questions[currentIndex].correctIndex) {
      score += 10;
      isLastAnswerCorrect = true; 
    } else {
      isLastAnswerCorrect = false; 
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    currentIndex = 0;
    score = 0;
    questions = [];
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadQuestionsFromJson() async {}
}