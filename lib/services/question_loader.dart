import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_model.dart';

class QuestionLoader {
  Future<List<QuestionModel>> loadQuestionsFromAssets() async {
    try {
      
      final jsonString = await rootBundle.loadString('assets/questions.json');
      
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final List<dynamic> questionList = jsonData['questions'];

      return questionList.map((json) => QuestionModel.fromJson(json)).toList();
    } catch (e) {
      print("JSON Yükleme Hatası: $e");
      return [];
    }
  }
}