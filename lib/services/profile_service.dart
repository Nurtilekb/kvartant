// lib/services/profile_service.dart
import 'package:_kvartant/models/user_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Сохранить профиль
  Future<void> saveProfile(UserProfile profile) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('Пользователь не авторизован');

      await _db.child('users').child(userId).set({
        'name': profile.name,
        'phone': profile.phone,
        'email': profile.email,
        'gender': profile.gender,
        'birthDate': profile.birthDate?.toIso8601String(),
        'bio': profile.bio,
        'photoUrl': profile.photoUrl,
        'isProfileComplete': profile.isProfileComplete,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      print('✅ Профиль сохранен для пользователя $userId');
    } catch (e) {
      print('❌ Ошибка сохранения профиля: $e');
      rethrow;
    }
  }

  // Загрузить профиль
  Future<UserProfile?> loadProfile() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        print('⚠️ Пользователь не авторизован');
        return null;
      }

      final snapshot = await _db.child('users').child(userId).get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        print('✅ Профиль загружен для пользователя $userId');

        return UserProfile(
          name: data['name'] ?? '',
          phone: data['phone'] ?? '',
          email: data['email'] ?? '',
          gender: data['gender'],
          birthDate: data['birthDate'] != null
              ? DateTime.parse(data['birthDate'])
              : null,
          bio: data['bio'],
          photoUrl: data['photoUrl'],
          isProfileComplete: data['isProfileComplete'] ?? false,
        );
      }

      print('ℹ️ Профиль не найден для пользователя $userId');
      return null;
    } catch (e) {
      print('❌ Ошибка загрузки профиля: $e');
      return null;
    }
  }

  // Обновить профиль (частичное обновление)
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('Пользователь не авторизован');

      updates['updatedAt'] = DateTime.now().toIso8601String();

      await _db.child('users').child(userId).update(updates);
      print('✅ Профиль обновлен для пользователя $userId');
    } catch (e) {
      print('❌ Ошибка обновления профиля: $e');
      rethrow;
    }
  }

  // Проверить, заполнен ли профиль
  Future<bool> isProfileComplete() async {
    final profile = await loadProfile();
    return profile?.isProfileComplete ?? false;
  }

  // Удалить профиль
  Future<void> deleteProfile() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('Пользователь не авторизован');

      await _db.child('users').child(userId).remove();
      print('✅ Профиль удален для пользователя $userId');
    } catch (e) {
      print('❌ Ошибка удаления профиля: $e');
      rethrow;
    }
  }
}
