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

  List<QuestionModel> _allLocalQuestions = [];
  List<QuestionModel> questions = [];
  CategoryModel? selectedCategory;
  
  int currentIndex = 0;
  int score = 0;
  bool isLoading = false;
  String errorMessage = '';
  bool isLastAnswerCorrect = false;
  bool isAiMode = false; 

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
    isAiMode = false; 
    
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
    print("🟢 1. BAŞLADI: startAiQuiz tetiklendi. Konu: $topic"); 
    
    isLoading = true;
    errorMessage = '';
    score = 0;
    currentIndex = 0;
    questions = [];
    isAiMode = true; 
    notifyListeners();

    try {
      String currentCatName = selectedCategory?.name ?? "Genel Kültür";
      String currentCatId = selectedCategory?.id ?? "genel";

      print("🟡 2. GEMINI: Soru isteniyor... ($currentCatName)");

      questions = await _geminiService.generateQuestions(topic, currentCatName);

      print("🟢 3. GEMINI: Cevap geldi! ${questions.length} soru üretildi."); 

      if (questions.isNotEmpty) {
        print("🟡 4. FIREBASE: Kayıt deneniyor...");
        
        await _firestoreService.saveAiQuizSet(
          topic: topic,
          categoryId: currentCatId, 
          questions: questions,
        );
        
        print("✅ 5. FIREBASE: Kayıt TAMAMLANDI!"); 
      } else {
        print("🔴 UYARI: Soru listesi boş geldiği için kayıt yapılmadı.");
      }

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print("🛑 HATA OLUŞTU (startAiQuiz): $e"); 
      
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

  void finishQuiz() {
    _firestoreService.saveScore(
      categoryId: selectedCategory?.id ?? 'genel',
      mode: isAiMode ? "ai" : "ready",
      score: score,
      totalQuestions: questions.length,
    );
  }

  void resetQuiz() {
    score = 0;
    currentIndex = 0;
    isLastAnswerCorrect = false;
    questions = [];
    errorMessage = '';
    selectedCategory = null; 
    isAiMode = false;
    notifyListeners();
  }
}