// lib/screens/auth/sign_in_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/services/profile_service.dart'; // Добавляем сервис профиля
import 'package:_kvartant/screens/auth/profile_setup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ProfileService _profileService = ProfileService();

  // Проверка заполнен ли профиль
  Future<void> _checkProfileAndNavigate() async {
    final profile = await _profileService.loadProfile();

    if (profile == null || !profile.isProfileComplete) {
      // Профиль не заполнен - идем на экран заполнения
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
      );
    } else {
      // Профиль заполнен - идем на главный экран
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  Future<void> _signInWithGoogle() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _showMessage('Вход через Google отменён');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        _showMessage('Не удалось получить токен Google');
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) await _checkProfileAndNavigate();
    } on FirebaseAuthException catch (e) {
      _showMessage('Ошибка Firebase: ${e.message}');
    } catch (e) {
      _showMessage('Ошибка входа через Google: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithApple() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        _showMessage('Не удалось получить токен Apple');
        return;
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      if (mounted) await _checkProfileAndNavigate();
    } on FirebaseAuthException catch (e) {
      _showMessage('Ошибка Firebase: ${e.message}');
    } catch (e) {
      _showMessage('Ошибка входа через Apple: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Введите email и пароль');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted) await _checkProfileAndNavigate();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Пользователь не найден';
          break;
        case 'wrong-password':
          message = 'Неверный пароль';
          break;
        case 'invalid-email':
          message = 'Некорректный email';
          break;
        default:
          message = 'Ошибка: ${e.message}';
      }
      _showMessage(message);
    } catch (e) {
      _showMessage('Ошибка входа: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              // Приветствие
              Text(
                'Hi, Welcome Back! 🥰',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 40),

              // Поле Email
              Text('Email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Поле Password
              Text('Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Кнопка Continue with Email
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Continue with Email'),
              ),
              SizedBox(height: 32),

              // Разделитель
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 32),

              // Кнопка Continue with Google
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('G',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    SizedBox(width: 8),
                    const Text('Continue with Google',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // Кнопка Continue with Apple
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithApple,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.apple, size: 24),
                    SizedBox(width: 8),
                    const Text('Continue with Apple',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 40),

              // Ссылка на регистрацию
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
