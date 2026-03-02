import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedGender;
  File? _profileImage;
  bool _isLoading = false;

  final List<String> _genders = ['Мужской', 'Женский', 'Другой'];

  // Текущий пользователь
  User? get _currentUser => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Если пользователь уже заполнял профиль, можно загрузить данные
    // _loadUserProfile();
  }

  // Загрузка существующих данных (если есть)
  // Future<void> _loadUserProfile() async {
  //   if (_currentUser == null) return;

  //   try {
  //     final doc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_currentUser!.uid)
  //         .get();

  //     if (doc.exists) {
  //       final data = doc.data()!;
  //       _nameController.text = data['name'] ?? '';
  //       _phoneController.text = data['phone'] ?? '';
  //       _cityController.text = data['city'] ?? '';
  //       _selectedGender = data['gender'];
  //       // Фото загружается отдельно, но можно показать существующее
  //       // Для этого нужно получить URL и загрузить через NetworkImage (но здесь упростим)
  //     }
  //   } catch (e) {
  //     print('Ошибка загрузки профиля: $e');
  //   }
  // }

  // Future<void> _pickImage() async {
  //   // final picker = ImagePicker();
  //   // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _profileImage = File(pickedFile.path);
  //     });
  //   }
  // }

  // // Future<void> _saveProfile() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   if (_currentUser == null) {
  //     _showMessage('Пользователь не авторизован');
  //     return;
  //   }

  //   setState(() => _isLoading = true);

  //   try {
  //     String? photoUrl;

  //     // 1. Если выбрано новое изображение — загружаем в Storage
  //     if (_profileImage != null) {
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('users')
  //           .child(_currentUser!.uid)
  //           .child('profile.jpg'); // можно добавить временную метку

  //       await storageRef.putFile(_profileImage!);
  //       photoUrl = await storageRef.getDownloadURL();
  //     }

  //     // 2. Сохраняем данные в Firestore
  //     final userData = {
  //       'name': _nameController.text.trim(),
  //       'phone': _phoneController.text.trim(),
  //       'gender': _selectedGender,
  //       'city': _cityController.text.trim(),
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     };

  //     // Если есть фото, добавляем поле photoUrl
  //     if (photoUrl != null) {
  //       userData['photoUrl'] = photoUrl;
  //     }

  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_currentUser!.uid)
  //         .set(userData, SetOptions(merge: true));

  //     if (mounted) {
  //       _showMessage('Профиль успешно сохранён!', isError: false);
  //       Navigator.pop(context);
  //     }
  //   } catch (e) {
  //     _showMessage('Ошибка сохранения: $e');
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  void _showMessage(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заполните профиль'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Фото профиля
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // ФИО
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'ФИО',
                      hintText: 'Введите ваше полное имя',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Введите ФИО'
                            : null,
                  ),
                  const SizedBox(height: 20),

                  // Телефон
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Номер телефона',
                      hintText: '+7 999 123-45-67',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите телефон';
                      }
                      final digits = value.replaceAll(RegExp(r'\D'), '');
                      if (digits.length < 10) {
                        return 'Минимум 10 цифр';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Пол
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Пол',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    hint: const Text('Выберите пол'),
                    items: _genders.map((g) {
                      return DropdownMenuItem(value: g, child: Text(g));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                    validator: (value) => value == null ? 'Выберите пол' : null,
                  ),
                  const SizedBox(height: 20),

                  // Город
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Город',
                      hintText: 'Введите ваш город',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Введите город'
                            : null,
                  ),
                  const SizedBox(height: 30),

                  // Кнопка сохранения
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      // _isLoading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Сохранить',
                              style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
