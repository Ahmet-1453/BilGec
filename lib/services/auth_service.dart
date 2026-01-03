import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      
      if (result.user != null) {
        if (!result.user!.emailVerified) {
          await _auth.signOut();
          throw Exception("Giriş yapabilmek için lütfen mail adresinize gönderilen doğrulama linkini onaylayın.");
        }
      }
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message = "Giriş başarısız.";
      if (e.code == 'user-not-found') {
        message = "Bu e-posta ile kayıtlı kullanıcı bulunamadı.";
      } else if (e.code == 'wrong-password') message = "Şifre hatalı.";
      else if (e.code == 'invalid-email') message = "Geçersiz e-posta formatı.";
      else if (e.code == 'user-disabled') message = "Kullanıcı hesabı engellenmiş.";
      
      debugPrint("Giriş Hatası: ${e.code}");
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<User?> signUp(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      if (result.user != null) {
        await result.user!.updateDisplayName(username);
        
        if (!result.user!.emailVerified) {
          await result.user!.sendEmailVerification();
          debugPrint("📨 Doğrulama maili gönderildi: $email");
        }

        await _auth.signOut();
        
        throw Exception("Kayıt Başarılı! Lütfen mail adresinize gönderilen doğrulama linkini onaylayıp giriş yapın.");
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String message = "Kayıt başarısız.";
      if (e.code == 'email-already-in-use') {
        message = "Bu e-posta zaten kullanımda.";
      } else if (e.code == 'weak-password') message = "Şifre çok zayıf (En az 6 karakter).";
      else if (e.code == 'invalid-email') message = "Geçersiz e-posta formatı.";
      
      debugPrint("Kayıt Hatası: ${e.code}");
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}