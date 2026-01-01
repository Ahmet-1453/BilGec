import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../services/question_loader.dart';

class QuizController extends ChangeNotifier {
  final QuestionLoader _loader = QuestionLoader();
  List<QuestionModel> _allReadyQuestions = []; 

  CategoryModel? selectedCategory;
  List<QuestionModel> questions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = false;
  bool isQuestionsLoaded = false;
  String errorMessage = '';
  bool isLastAnswerCorrect = false;

  Future<void> initReadyQuestions() async {
    if (isQuestionsLoaded) return;
    isLoading = true;
    notifyListeners();

    _allReadyQuestions = await _loader.loadQuestionsFromAssets();
    isQuestionsLoaded = true;
    isLoading = false;
    notifyListeners();
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }


  Future<void> startReadyQuiz() async {
    isLoading = true;
    score = 0;
    currentIndex = 0;
    questions = [];
    notifyListeners();


    if (!isQuestionsLoaded || _allReadyQuestions.isEmpty) {
      await initReadyQuestions();
    }

    if (selectedCategory != null) {

      List<QuestionModel> pool = _allReadyQuestions
          .where((q) => q.categoryId == selectedCategory!.id)
          .toList();


      if (pool.isEmpty) {
        pool.add(QuestionModel(
          categoryId: selectedCategory!.id,
          questionText: "${selectedCategory!.name} için soru bulunamadı.",
          options: ["-", "-", "-", "-"],
          correctIndex: 0,
          explanation: "Yöneticiye bildir.",
        ));
      }


      List<QuestionModel> finalQuestions = [];
      if (pool.isNotEmpty) {
        while (finalQuestions.length < 10) {
          pool.shuffle();
          finalQuestions.addAll(pool);
        }
        questions = finalQuestions.sublist(0, 10);
      }
    }

    isLoading = false;
    notifyListeners();
  }

 
  Future<void> startAiQuizPlaceholder(String topic) async {
    isLoading = true;
    score = 0;
    currentIndex = 0;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    questions = List.generate(10, (index) => QuestionModel(
      categoryId: 'ai',
      questionText: '$topic hakkında AI sorusu #${index + 1}',
      options: ['A', 'B', 'C', 'D'],
      correctIndex: 0,
      explanation: 'AI entegrasyonu sonraki adımda.',
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
}