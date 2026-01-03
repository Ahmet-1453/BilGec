import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "Kullanıcı";
    final email = user?.email ?? "Misafir";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        elevation: 0,
        centerTitle: true,
        title: const Text("Profil", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))]),
              child: Column(
                children: [
                  CircleAvatar(radius: 45, backgroundColor: Colors.indigo.shade50, child: Icon(Icons.person, size: 45, color: Colors.indigo.shade400)),
                  const SizedBox(height: 16),
                  Text(displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(email, style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            FutureBuilder<int>(
              future: _firestoreService.getTotalScore(),
              builder: (context, snapshot) {
                int totalScore = snapshot.data ?? 0;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))]),
                  child: Column(
                    children: [
                      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.amber.shade50, shape: BoxShape.circle), child: const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 36)),
                      const SizedBox(height: 12),
                      Text("TOPLAM PUAN", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1.2)),
                      Text("$totalScore", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black87)),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Align(alignment: Alignment.centerLeft, child: Text("İstatistikler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800))),
            const SizedBox(height: 16),
            
            FutureBuilder<Map<String, int>>(
              future: _firestoreService.getUserStats(),
              builder: (context, snapshot) {
                final stats = snapshot.data ?? {'ai': 0, 'standard': 0, 'total': 0};
                
                return Column(
                  children: [
                    _buildStatTile(Icons.auto_awesome, "Yapay Zeka Quizleri", Colors.purple.shade50, Colors.purple, stats['ai']!),
                    const SizedBox(height: 12),
                    _buildStatTile(Icons.list_alt, "Standart Quizler", Colors.blue.shade50, Colors.blue, stats['standard']!),
                    const SizedBox(height: 12),
                    _buildStatTile(Icons.help_outline, "Toplam Quizler", Colors.pink.shade50, Colors.pink, stats['total']!),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  await _authService.signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.logout_rounded), SizedBox(width: 10), Text("Çıkış Yap", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(IconData icon, String title, Color bgColor, Color iconColor, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 22)),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 15))),
          Text("$count", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
        ],
      ),
    );
  }
}