import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/quiz_controller.dart';
import '../widgets/mode_card.dart';
import 'quiz_screen.dart';
import 'ai_topic_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  String _getCategoryDescription(String categoryId) {
    switch (categoryId) {
      case 'tarih': 
        return "Osmanlı'dan Cumhuriyet'e, savaşlardan antlaşmalara... Tarih bilgine ne kadar güveniyorsun?";
      case 'cografya': 
        return "Başkentler, dağlar, denizler... Harita bilgin ne kadar iyi? Kendini test etmeye hazırlan.";
      case 'fen_bilimleri': 
        return "Atomlardan fizik kurallarına, biyolojiden kimyaya... Bilim dünyasında ne kadar iyisin?";
      case 'muzik': 
        return "Müzik tarihinden popüler şarkıcılara, enstrümanlardan notalara... Ritmi yakalayabilecek misin?";
      case 'film_sinema': 
        return "Yönetmenler, ödüllü filmler ve unutulmaz replikler... Tam bir sinefil misin, kanıtla!";
      case 'spor': 
        return "Skorlar, rekorlar ve efsane sporcular... Spor dünyasındaki genel kültürünü konuştur.";
      case 'edebiyat': 
        return "Klasik eserler, ünlü şairler ve yazarlar... Kitap kurdu olduğunu kanıtlamaya hazır mısın?";
      case 'astronomi': 
        return "Gezegenler, yıldızlar ve evrenin gizemleri... Uzay bilginle bizi şaşırtabilir misin?";
      case 'sanat_kultur': 
        return "Ünlü ressamlar, tablolar ve dünya kültürleri... Sanat genel kültürünü ölçme vakti!";
      case 'mitoloji': 
        return "Zeus, Thor ve antik efsaneler... Mitolojik kahramanları ne kadar tanıyorsun?";
      default: 
        return "Bu alandaki bilgilerini yarışarak test et ve yeni rekorlar kır!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuizController>(context);
    final category = controller.selectedCategory;

    if (category == null) return const Scaffold(body: Center(child: Text("Kategori Seçilmedi")));

    final String description = _getCategoryDescription(category.id);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.name,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 80,
                    color: category.color.withOpacity(0.5),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "${category.name} Kategorisi",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 12),
              
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 32),

              ModeCard(
                title: "Hazır Test Çöz",
                subtitle: "Editörlerin seçtiği sorularla hemen yarışmaya başla.",
                icon: Icons.assignment,
                headerColor: const Color(0xFFFFB74D), // Turuncu

                onTap: () {
                  controller.startReadyQuiz();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                },
              ),

              ModeCard(
                title: "AI ile Test Üret",
                subtitle: "Yapay zeka senin için özel ve benzersiz sorular hazırlasın.",
                icon: Icons.auto_awesome,
                headerColor: const Color(0xFF64B5F6), 
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AiTopicScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}