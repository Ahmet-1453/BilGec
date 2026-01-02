import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../services/gemini_service.dart';

class QuizController extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  List<QuestionModel> _allLocalQuestions = [];
  List<QuestionModel> questions = [];
  CategoryModel? selectedCategory;
  
  int currentIndex = 0;
  int score = 0;
  bool isLoading = false;
  String errorMessage = '';
  bool isLastAnswerCorrect = false;

  QuizController() {
    _loadLocalJson();
  }

  Future<void> _loadLocalJson() async {
    try {
      final String response = await rootBundle.loadString('assets/questions.json');
      final data = json.decode(response);
      if (data['questions'] != null) {
        _allLocalQuestions = (data['questions'] as List)
            .map((q) => QuestionModel.fromJson(q))
            .toList();
      }
    } catch (e) {
      debugPrint("JSON Yükleme Hatası: $e");
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
    
    if (selectedCategory != null) {
      List<QuestionModel> categoryQuestions = _allLocalQuestions
          .where((q) => q.categoryId == selectedCategory!.id)
          .toList();
      
      categoryQuestions.shuffle();

      questions = categoryQuestions.take(10).toList();
          
      if (questions.isEmpty) {
        errorMessage = "Bu kategoride henüz hazır soru bulunmuyor.";
      }
    } else {
      questions = [];
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
    notifyListeners();

    try {
      String currentCatName = selectedCategory?.name ?? "Genel Kültür";
      questions = await _geminiService.generateQuestions(topic, currentCatName);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception:', '').trim();
      isLoading = false;
      notifyListeners();
      return false;
    }
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
    score = 0;
    currentIndex = 0;
    isLastAnswerCorrect = false;
    questions = [];
    errorMessage = '';
    selectedCategory = null; 
    notifyListeners();
  }
}