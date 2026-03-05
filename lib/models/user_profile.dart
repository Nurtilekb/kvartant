// lib/models/user_profile.dart
class UserProfile {
  final String name;
  final String phone;
  final String email;
  final String? gender;
  final DateTime? birthDate;
  final String? bio;
  final String? photoUrl;
  final bool isProfileComplete;

  UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    this.gender,
    this.birthDate,
    this.bio,
    this.photoUrl,
    this.isProfileComplete = false,
  });

  // Для копирования с изменениями
  UserProfile copyWith({
    String? name,
    String? phone,
    String? email,
    String? gender,
    DateTime? birthDate,
    String? bio,
    String? photoUrl,
    bool? isProfileComplete,
  }) {
    return UserProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  // Преобразование в JSON для сохранения
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'bio': bio,
      'photoUrl': photoUrl,
      'isProfileComplete': isProfileComplete,
    };
  }

  // Создание из JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      bio: json['bio'],
      photoUrl: json['photoUrl'],
      isProfileComplete: json['isProfileComplete'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserProfile(name: $name, phone: $phone, email: $email, isProfileComplete: $isProfileComplete)';
  }
}
