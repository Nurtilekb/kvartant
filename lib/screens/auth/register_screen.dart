import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:_kvartant/core/app_theme.dart';

/// Экран регистрации через Firebase
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Регистрация через Firebase
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        await userCredential.user!
            .updateDisplayName(_nameController.text.trim());
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Регистрация успешна! Добро пожаловать!'),
            backgroundColor: AppColors.success,
          ),
        );

        Navigator.of(context).pushReplacementNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage;
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'Этот email уже зарегистрирован';
            break;
          case 'invalid-email':
            errorMessage = 'Неверный формат email';
            break;
          case 'weak-password':
            errorMessage = 'Слишком слабый пароль';
            break;
          default:
            errorMessage = 'Ошибка: ${e.message}';
        }
        _showMessage(errorMessage);
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Ошибка регистрации: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Create Account', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSizes.lg),

                // Заголовок
                Text('Sign Up', style: AppTextStyles.headline, textAlign: TextAlign.center),
                SizedBox(height: AppSizes.sm),
                Text('Create your account to get started', style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
                SizedBox(height: AppSizes.xxl),

                // Поле имени
                Text('Full Name', style: AppTextStyles.label),
                SizedBox(height: AppSizes.sm),
                TextFormField(
                  controller: _nameController,
                  decoration: AppDecorations.inputField(hintText: 'Enter your full name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Введите имя';
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                // Поле Email
                Text('Email', style: AppTextStyles.label),
                SizedBox(height: AppSizes.sm),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.inputField(hintText: 'Enter your email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Введите email';
                    if (!value.contains('@')) return 'Введите корректный email';
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.lg),

                // Поле пароля
                Text('Password', style: AppTextStyles.label),
                SizedBox(height: AppSizes.sm),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: AppDecorations.inputField(
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.grey500,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Введите пароль';
                    if (value.length < 6) return 'Пароль должен быть не менее 6 символов';
                    return null;
                  },
                ),
                SizedBox(height: AppSizes.xxl),

                // Кнопка регистрации
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
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
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          ),
                        )
                      : Text('Sign Up', style: AppTextStyles.button),
                ),
                SizedBox(height: AppSizes.lg),

                // Ссылка на вход
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: AppTextStyles.bodySmall),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Sign In', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.xxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
