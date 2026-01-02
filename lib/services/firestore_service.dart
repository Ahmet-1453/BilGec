import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/question_model.dart';

class FirestoreService {
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  Future<void> saveAiQuizSet({
    required String topic,
    required String categoryId,
    required List<QuestionModel> questions,
  }) async {
    try {
      List<Map<String, dynamic>> questionsData =
          questions.map((q) => q.toMap()).toList();

      await _db.collection('ai_quiz_sets').add({
        'topic': topic,
        'categoryId': categoryId,
        'questions': questionsData,
        'createdAt': FieldValue.serverTimestamp(), 
      });
      debugPrint("✅ Firebase: AI soruları başarıyla kaydedildi.");
    } catch (e) {
      debugPrint("⚠️ Firebase Kayıt Hatası: $e");
    }
  }

  Future<void> saveScore({
    required String categoryId,
    required String mode, 
    required int score,
    required int totalQuestions,
  }) async {
    try {
      await _db.collection('score_history').add({
        'categoryId': categoryId,
        'mode': mode,
        'score': score,
        'totalQuestions': totalQuestions,
        'createdAt': FieldValue.serverTimestamp(),
      });
      debugPrint("✅ Firebase: Skor kaydedildi.");
    } catch (e) {
      debugPrint("⚠️ Firebase Skor Hatası: $e");
    }
  }
}