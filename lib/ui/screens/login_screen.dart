import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'home_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  
  bool _isLogin = true; 
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _authenticate() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun.")),
      );
      return;
    }

    if (!_isLogin && _usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen kullanıcı adınızı girin.")),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      if (_isLogin) {
        await _authService.signIn(
            _emailController.text.trim(), 
            _passwordController.text.trim()
        );
      } else {
        await _authService.signUp(
            _emailController.text.trim(), 
            _passwordController.text.trim(),
            _usernameController.text.trim()
        );
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. LOGO ALANI
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(Icons.school, size: 64, color: Colors.indigo.shade800),
              ),
              const SizedBox(height: 24),
              Text(
                "BilGeç",
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.w900, 
                  color: Colors.indigo.shade900,
                  letterSpacing: -1
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Bilgini Test Et, Kendini Geliştir",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.indigo.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        _isLogin ? "Giriş Yap" : "Kayıt Ol",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.indigo.shade900),
                      ),
                    ),
                    const SizedBox(height: 30),

                    if (!_isLogin) ...[
                      _buildLabel("Kullanıcı Adı"),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: "Adınız",
                          prefixIcon: const Icon(Icons.badge_outlined, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.indigo)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    _buildLabel("E-posta"),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "ornek@mail.com",
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.indigo)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildLabel("Şifre"),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "••••••",
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.indigo)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _authenticate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            _isLogin ? "GİRİŞ YAP" : "KAYIT OL",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      if (_isLogin) _usernameController.clear();
                    });
                  },
                  child: Text(
                    _isLogin ? "Hesabın yok mu? Kayıt Ol" : "Zaten hesabın var mı? Giriş Yap",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}