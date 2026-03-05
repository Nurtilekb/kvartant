// lib/screens/auth/profile_setup_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:_kvartant/services/profile_service.dart'; // Импортируем сервис
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_profile.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  File? _profileImage;
  String? _selectedGender;
  DateTime? _selectedDate;
  bool _isLoading = false;

  final List<String> _genders = ['Мужской', 'Женский', 'Не указан'];
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      // Загружаем существующий профиль
      final profile = await _profileService.loadProfile();
      final user = FirebaseAuth.instance.currentUser;

      if (profile != null) {
        _nameController.text = profile.name;
        _phoneController.text = profile.phone;
        _emailController.text = profile.email;
        _bioController.text = profile.bio ?? '';
        _selectedGender = profile.gender;
        _selectedDate = profile.birthDate;
      } else if (user != null) {
        // Если профиля нет, но есть пользователь - подставляем данные из Firebase Auth
        _nameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final profile = UserProfile(
          name: _nameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          gender: _selectedGender,
          birthDate: _selectedDate,
          bio: _bioController.text,
          isProfileComplete: true,
        );

        await _profileService.saveProfile(profile);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Профиль успешно сохранен!'),
              backgroundColor: Colors.green,
            ),
          );

          // Переходим на главный экран
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        if (mounted) {
          print('❌ Ошибка сохранения профиля: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Ошибка: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pickImage() async {
    // TODO: Реализовать позже
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ?? DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Заполните профиль'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Фото профиля (можно добавить позже)
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person,
                                size: 50, color: Colors.grey[400]),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Форма
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Имя',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Введите имя';
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Телефон',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Введите телефон';
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Введите email';
                        if (!value.contains('@'))
                          return 'Введите корректный email';
                        return null;
                      },
                    ),

                    SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Пол',
                        border: OutlineInputBorder(),
                      ),
                      items: _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Дата рождения',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Выберите дату'
                                  : '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}',
                            ),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                        labelText: 'О себе',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),

                    SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('Сохранить'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
