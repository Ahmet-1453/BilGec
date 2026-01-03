import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/question_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> saveAiQuizSet({
    required String topic,
    required String categoryId,
    required List<QuestionModel> questions,
  }) async {
    if (currentUserId == null) return;

    try {
      List<Map<String, dynamic>> questionsData =
          questions.map((q) => q.toMap()).toList();

      await _db.collection('ai_quiz_sets').add({
        'userId': currentUserId,
        'topic': topic,
        'categoryId': categoryId,
        'questions': questionsData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Kayıt Hatası: $e");
    }
  }

  Future<void> saveScore({
    required String categoryId,
    required int score,
    required int totalQuestions,
    required String quizType, 
  }) async {
    if (currentUserId == null) return;

    try {
      await _db.collection('score_history').add({
        'userId': currentUserId,
        'categoryId': categoryId,
        'score': score,
        'totalQuestions': totalQuestions,
        'quizType': quizType, 
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Puan Hatası: $e");
    }
  }

  Future<Map<String, int>> getUserStats() async {
    if (currentUserId == null) return {'ai': 0, 'standard': 0, 'total': 0};

    try {
      final snapshot = await _db
          .collection('score_history')
          .where('userId', isEqualTo: currentUserId)
          .get();

      int aiCount = 0;
      int standardCount = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data['quizType'] == 'ai') {
          aiCount++;
        } else {
          standardCount++;
        }
      }

      return {
        'ai': aiCount,
        'standard': standardCount,
        'total': aiCount + standardCount,
      };
    } catch (e) {
      return {'ai': 0, 'standard': 0, 'total': 0};
    }
  }

  Future<int> getTotalScore() async {
    if (currentUserId == null) return 0;
    try {
      final snapshot = await _db
          .collection('score_history')
          .where('userId', isEqualTo: currentUserId)
          .get();

      int total = 0;
      for (var doc in snapshot.docs) {
        total += (doc.data()['score'] as int? ?? 0);
      }
      return total;
    } catch (e) {
      return 0;
    }
  }

  Stream<QuerySnapshot> getCategoryHistory(String categoryId) {
    if (currentUserId == null) return const Stream.empty();

    return _db
        .collection('ai_quiz_sets')
        .where('userId', isEqualTo: currentUserId)
        .where('categoryId', isEqualTo: categoryId)
        .snapshots();
  }

  Future<void> deleteAiQuizSet(String docId) async {
    try {
      await _db.collection('ai_quiz_sets').doc(docId).delete();
    } catch (e) {
      debugPrint("Silme hatası: $e");
    }
  }
}