import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../state/quiz_controller.dart';
import 'quiz_screen.dart';

class AiTopicScreen extends StatefulWidget {
  const AiTopicScreen({super.key});

  @override
  State<AiTopicScreen> createState() => _AiTopicScreenState();
}

class _AiTopicScreenState extends State<AiTopicScreen> {
  final TextEditingController _topicController = TextEditingController();
  
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

  void _cancelGeneration() {
    _stopLoadingTimer();
    Navigator.pop(context);
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
    final Color categoryColor = controller.selectedCategory?.color ?? const Color(0xFFFBC02D);
    final Color textColor = const Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "$categoryName - AI Modu", 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: categoryColor, 
                  ),
                  
                  const SizedBox(height: 30),

                  Text(
                    "$categoryName alanında hangi konuda yarışmak istersin?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  const Text(
                    "Konuyu yaz, AI senin için özel sorular hazırlasın.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: categoryColor.withOpacity(0.3), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: categoryColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _topicController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Konuyu buraya yazın...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (controller.errorMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              controller.errorMessage,
                              style: TextStyle(color: Colors.red.shade800, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
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
                          shadowColor: categoryColor.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.auto_awesome, size: 24),
                            SizedBox(width: 12),
                            Text(
                              "Soruları Üret",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300, 
                        width: 300,
                        child: Lottie.asset(
                          'assets/animations/ai_loading.json',
                          errorBuilder: (context, error, stackTrace) {
                            return CircularProgressIndicator(
                              color: categoryColor,
                              strokeWidth: 8,
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 30),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          _loadingMessages[_loadingTextIndex],
                          key: ValueKey<int>(_loadingTextIndex),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      TextButton(
                        onPressed: _cancelGeneration,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "İptal Et",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
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