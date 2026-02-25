import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Экран входа с Google, Apple и регистрацией
class ExactSignInScreen extends StatefulWidget {
  const ExactSignInScreen({super.key});

  @override
  State<ExactSignInScreen> createState() => _ExactSignInScreenState();
}

class _ExactSignInScreenState extends State<ExactSignInScreen> {
  bool _isLoading = false;

  // Вход через Google
  Future<void> _signInWithGoogle() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        // Успешный вход через Google
        // Здесь можно получить данные пользователя:
        // googleUser.email
        // googleUser.displayName
        // googleUser.photoUrl

        if (mounted) {
          _navigateToHome();
        }
      } else {
        // Пользователь отменил вход
        if (mounted) {
          _showMessage('Вход через Google отменён');
        }
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Ошибка входа через Google: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Вход через Apple
  Future<void> _signInWithApple() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
      );

      // Если получены данные — вход успешен
      if (credential.authorizationCode.isNotEmpty) {
        // Здесь можно получить данные пользователя:
        // credential.email
        // credential.givenName
        // credential.familyName

        if (mounted) {
          _navigateToHome();
        }
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Ошибка входа через Apple: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Переход на главный экран
  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  // Переход на экран регистрации
  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  // Показать сообщение
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // Приветственный заголовок
              const Text(
                'Hi, Welcome Back! 🥰',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Подзаголовок
              const Text(
                'Lorem ipsum dolor sit amet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Метка Email
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Поле ввода Email
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Кнопка "Continue with Email"
              ElevatedButton(
                onPressed: () {
                  // Переход на экран регистрации по email
                  _navigateToRegister();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue with Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 30),

              // Разделитель "Or continue with"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 30),

              // Кнопка "Continue with Google"
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 40,
                      child: Center(
                        child: Image.asset(
                            'assets/icons/google.png', // убедитесь, что путь правильный
                            width: 30,
                            height: 30),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Кнопка "Continue with Apple"
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithApple,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 40,
                      child: Center(
                        child: Image.asset(
                            'assets/icons/apple.png', // убедитесь, что путь правильный
                            width: 30,
                            height: 30),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Continue with Apple',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Строка "Don’t have an account? Sign Up"
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Индикатор загрузки
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
