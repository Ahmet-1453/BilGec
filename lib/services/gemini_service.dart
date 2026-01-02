import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/question_model.dart';
import '../api_key.dart';

class GeminiService {

  Future<List<QuestionModel>> generateQuestions(String topic, String categoryName) async {

    final model = GenerativeModel(
      model: 'gemini-2.5-flash', 
      apiKey: ApiKey.gemini,      
      generationConfig: GenerationConfig(
        temperature: 0.7,
      ),
    );

    final prompt = '''
      SENİN GÖREVİN: "$categoryName" kategorisi için içerik denetleyicisi ve soru üreticisisin.
      KULLANICI GİRDİSİ: "$topic"

      1. ADIM (DENETLEME):
      Kullanıcının girdiği konu ($topic), seçili kategori ($categoryName) ile alakalı mı?
      
      EĞER ALAKASIZ İSE ŞU JSON'U DÖNDÜR VE DUR:
      {
        "error": "Girdiğiniz konu ($topic), seçili kategoriye uymuyor."
      }

      EĞER ALAKALI İSE:
      "$topic" konusu hakkında 10 adet Türkçe, çoktan seçmeli soru üret.
      
      ÇIKTI KURALLARI:
      - Çıktın SADECE geçerli bir JSON olmalı. Başında ```json veya sonunda ``` olmasın.
      - "questions" listesi döndür.
      - "options" listesi her zaman 4 şık olmalı.
      - "correctIndex" 0-3 arası olmalı.
      - "categoryId" değeri sabit "ai" olsun.

      İSTENEN JSON FORMATI:
      {
        "questions": [
          {
            "id": "ai_1",
            "questionText": "Soru metni?",
            "options": ["Cevap A", "Cevap B", "Cevap C", "Cevap D"],
            "correctIndex": 0,
            "explanation": "Açıklama.",
            "categoryId": "ai"
          }
        ]
      }
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      String? responseText = response.text;
      if (responseText == null) throw Exception("AI yanıt vermedi.");

      responseText = responseText.replaceAll('```json', '').replaceAll('```', '').trim();

      if (responseText.startsWith('"') && responseText.endsWith('"')) {
         responseText = responseText.substring(1, responseText.length - 1);
      }

      final Map<String, dynamic> jsonMap = jsonDecode(responseText);

      if (jsonMap.containsKey('error')) {
        throw Exception(jsonMap['error']);
      }
      
      if (!jsonMap.containsKey('questions')) {
        throw Exception("JSON formatı hatalı.");
      }

      List<dynamic> qList = jsonMap['questions'];
      return qList.map((q) => QuestionModel.fromJson(q)).toList();

    } catch (e) {
      String msg = e.toString().replaceAll("Exception:", "").trim();
      throw Exception("Bir hata oluştu: $msg");
    }
  }
}