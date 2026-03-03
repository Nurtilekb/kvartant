import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:_kvartant/core/app_theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // --------------------------------------------------------------------------
  // Вход через Google
  // --------------------------------------------------------------------------
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

      if (mounted) _navigateToHome();
    } on FirebaseAuthException catch (e) {
      _showMessage('Ошибка Firebase: ${e.message}');
    } catch (e) {
      _showMessage('Ошибка входа через Google: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --------------------------------------------------------------------------
  // Вход через Apple
  // --------------------------------------------------------------------------
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

      if (mounted) _navigateToHome();
    } on FirebaseAuthException catch (e) {
      _showMessage('Ошибка Firebase: ${e.message}');
    } catch (e) {
      _showMessage('Ошибка входа через Apple: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --------------------------------------------------------------------------
  // Вход по Email/Password
  // --------------------------------------------------------------------------
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

      if (mounted) _navigateToHome();
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

  // --------------------------------------------------------------------------
  // Навигация
  // --------------------------------------------------------------------------
  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  // --------------------------------------------------------------------------
  // Сообщения
  // --------------------------------------------------------------------------
  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSizes.xxxl),
              // Приветствие
              Text(
                'Hi, Welcome Back! 🥰',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline,
              ),
              SizedBox(height: AppSizes.sm),
              Text(
                'Lorem ipsum dolor sit amet',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ),
              SizedBox(height: AppSizes.xxxl),

              // Поле Email
              Text('Email', style: AppTextStyles.label),
              SizedBox(height: AppSizes.sm),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: AppDecorations.inputField(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: AppSizes.lg),

              // Поле Password
              Text('Password', style: AppTextStyles.label),
              SizedBox(height: AppSizes.sm),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: AppDecorations.inputField(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: AppSizes.lg),

              // Кнопка Continue with Email
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.white),
                        ),
                      )
                    : const Text('Continue with Email'),
              ),
              SizedBox(height: AppSizes.xxl),

              // Разделитель
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.grey300)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
                    child: Text(
                      'Or continue with',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.grey300)),
                ],
              ),
              SizedBox(height: AppSizes.xxl),

              // Кнопка Continue with Google
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                style: AppDecorations.secondaryButton,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('G',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    SizedBox(width: AppSizes.sm),
                    const Text('Continue with Google',
                        style: TextStyle(fontSize: 16, color: AppColors.black)),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.md),

              // Кнопка Continue with Apple
              OutlinedButton(
                onPressed: _isLoading ? null : _signInWithApple,
                style: AppDecorations.secondaryButton,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.apple, size: 24),
                    SizedBox(width: AppSizes.sm),
                    const Text('Continue with Apple',
                        style: TextStyle(fontSize: 16, color: AppColors.black)),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xxxl),

              // Ссылка на регистрацию
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account? ",
                      style: AppTextStyles.bodySmall),
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
