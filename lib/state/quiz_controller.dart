import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../services/gemini_service.dart';
import '../services/firestore_service.dart';

class QuizController extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final FirestoreService _firestoreService = FirestoreService(); 

  List<QuestionModel> _allJsonQuestions = []; 
  List<QuestionModel> questions = [];
  CategoryModel? selectedCategory;
  
  int currentIndex = 0;
  int score = 0; 
  bool isLoading = false;
  String errorMessage = '';
  bool isLastAnswerCorrect = false;
  bool isAiMode = false; 

  QuizController() {
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/questions.json');
      final data = json.decode(response);
      
      if (data['questions'] != null) {
        _allJsonQuestions = (data['questions'] as List)
            .map((q) => QuestionModel.fromJson(q))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("JSON Hatası: $e");
    }
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }

  void startReadyQuiz() {
    isLoading = true;
    errorMessage = '';
    score = 0;
    currentIndex = 0;
    isAiMode = false; 
    
    if (selectedCategory != null) {
      List<QuestionModel> categoryQuestions = _allJsonQuestions
          .where((q) => q.categoryId == selectedCategory!.id)
          .toList();
      
      if (categoryQuestions.isNotEmpty) {
        categoryQuestions.shuffle();
        
        int count = categoryQuestions.length > 10 ? 10 : categoryQuestions.length;
        questions = categoryQuestions.take(count).toList();
      } else {
        questions = [];
        errorMessage = "Bu kategoride (${selectedCategory!.name}) hazır soru bulunamadı.";
      }
    }
    
    isLoading = false;
    notifyListeners();
  }

  Future<bool> startAiQuiz(String topic) async {
    isLoading = true;
    errorMessage = '';
    score = 0;
    currentIndex = 0;
    questions = [];
    isAiMode = true; 
    notifyListeners();

    try {
      String currentCatName = selectedCategory?.name ?? "Genel";
      String currentCatId = selectedCategory?.id ?? "genel";

      questions = await _geminiService.generateQuestions(topic, currentCatName);

      if (questions.isNotEmpty) {
        await _firestoreService.saveAiQuizSet(
          topic: topic,
          categoryId: currentCatId, 
          questions: questions,
        );
      } else {
        errorMessage = "Yapay zeka soru üretemedi.";
      }

      isLoading = false;
      notifyListeners();
      return questions.isNotEmpty;
    } catch (e) {
      errorMessage = "Hata: $e";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void startHistoryQuiz(List<QuestionModel> historyQuestions) {
    questions = historyQuestions;
    score = 0;
    currentIndex = 0;
    isAiMode = true;
    isLoading = false;
    errorMessage = '';
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

  Future<void> finishQuiz() async {
    await _firestoreService.saveScore(
      categoryId: selectedCategory?.id ?? 'genel',
      score: score,
      totalQuestions: questions.length,
      quizType: isAiMode ? 'ai' : 'standard', 
    );
    notifyListeners();
  }

  void resetQuiz() {
    score = 0;
    currentIndex = 0;
    isLastAnswerCorrect = false;
    questions = [];
    errorMessage = '';
    isAiMode = false;
    notifyListeners();
  }
}