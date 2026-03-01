import 'package:flutter/material.dart';

/// Экран выбора языка
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Language',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 16),

            // Suggested Languages
            const Text(
              'Suggested Languages',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildLanguageItem('English (UK)'),
            _buildLanguageItem('English'),
            _buildLanguageItem('Bahasa Indonesia'),

            const SizedBox(height: 24),

            // Other Languages
            const Text(
              'Other Languages',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildLanguageItem('Chinesees'), // так на скриншоте
            _buildLanguageItem('Croatian'),
            _buildLanguageItem('Czech'),
            _buildLanguageItem('Danish'),
            _buildLanguageItem('Filipino'),
            _buildLanguageItem('Finland'), // так на скриншоте (вместо Finnish)

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem(String language) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        language,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
