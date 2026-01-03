import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../../state/quiz_controller.dart';
import '../../models/question_model.dart';
import 'quiz_screen.dart';
import '../../services/firestore_service.dart';

class AiTopicScreen extends StatefulWidget {
  const AiTopicScreen({super.key});

  @override
  State<AiTopicScreen> createState() => _AiTopicScreenState();
}

class _AiTopicScreenState extends State<AiTopicScreen> {
  final TextEditingController _topicController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService(); 

  int _loadingTextIndex = 0;
  Timer? _loadingTimer;
  final List<String> _loadingMessages = [
    "Konu analiz ediliyor...",
    "Zorlu sorular hazırlanıyor...",
    "Şıklar üretiliyor...",
    "Neredeyse hazır!"
  ];

  @override
  void dispose() {
    _stopLoadingTimer();
    _topicController.dispose();
    super.dispose();
  }

  void _startLoadingTimer() {
    _loadingTextIndex = 0;
    _loadingTimer?.cancel();
    _loadingTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {
          _loadingTextIndex = (_loadingTextIndex + 1) % _loadingMessages.length;
        });
      }
    });
  }

  void _stopLoadingTimer() {
    _loadingTimer?.cancel();
    _loadingTimer = null;
  }

  void _startGeneration() async {
    final controller = Provider.of<QuizController>(context, listen: false);
    final topic = _topicController.text.trim();

    if (topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen bir konu başlığı girin.")),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    _startLoadingTimer();

    bool success = await controller.startAiQuiz(topic);

    _stopLoadingTimer();

    if (success && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const QuizScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context);
    final categoryName = controller.selectedCategory?.name ?? "Genel";
    final categoryId = controller.selectedCategory?.id ?? "genel"; 
    final Color categoryColor = controller.selectedCategory?.color ?? const Color(0xFFFBC02D);
    final Color textColor = const Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("$categoryName - AI Modu", style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 80, color: categoryColor),
                  const SizedBox(height: 30),
                  Text(
                    "$categoryName alanında hangi konuda yarışmak istersin?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: textColor),
                  ),
                  const SizedBox(height: 12),
                  const Text("Konuyu yaz, AI senin için özel sorular hazırlasın.", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: categoryColor.withOpacity(0.3), width: 1.5),
                      boxShadow: [BoxShadow(color: categoryColor.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _topicController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Konuyu buraya yazın...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (!controller.isLoading)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _startGeneration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: categoryColor, 
                          foregroundColor: textColor, 
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.auto_awesome, size: 24),
                            SizedBox(width: 12),
                            Text("Soruları Üret", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                   
                   const SizedBox(height: 40),
                   
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                       "Son Oluşturulanlar (Geçmiş):",
                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                     ),
                   ),
                   const SizedBox(height: 10),

                   StreamBuilder<QuerySnapshot>(
                    stream: _firestoreService.getCategoryHistory(categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: const Text("Henüz bu kategoride kayıtlı test yok.", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                        );
                      }

                      var docs = snapshot.data!.docs;
                      
                      docs.sort((a, b) {
                        var aTime = (a.data() as Map<String, dynamic>)['createdAt'];
                        var bTime = (b.data() as Map<String, dynamic>)['createdAt'];
                        if (aTime == null || bTime == null) return 0;
                        return (bTime as Timestamp).compareTo(aTime as Timestamp);
                      });

                      var limitedDocs = docs.reversed.take(5).toList();

                      return ListView.builder(
                        shrinkWrap: true, 
                        physics: const NeverScrollableScrollPhysics(), 
                        itemCount: limitedDocs.length,
                        itemBuilder: (context, index) {
                          var data = limitedDocs[index].data() as Map<String, dynamic>;
                          var docId = limitedDocs[index].id;
                          var topic = data['topic'] ?? 'Konu Yok';
                          List<dynamic> rawQuestions = data['questions'] ?? [];
                          
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: categoryColor.withOpacity(0.2),
                                child: Icon(Icons.history, color: categoryColor),
                              ),
                              title: Text(topic, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("${rawQuestions.length} Soru • Tekrar Çöz"),
                              onTap: () {
                                List<QuestionModel> historyQuestions = rawQuestions
                                    .map((q) => QuestionModel.fromJson(q))
                                    .toList();
                                
                                controller.startHistoryQuiz(historyQuestions);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                                );
                              },
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                onPressed: () {
                                  _firestoreService.deleteAiQuizSet(docId);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          if (controller.isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.white.withOpacity(0.90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200, width: 200, child: Lottie.asset('assets/animations/ai_loading.json')),
                      const SizedBox(height: 20),
                      Text(
                        _loadingMessages[_loadingTextIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}