/// Модель чата
class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
  });

  /// Создание чата из JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      time: json['time'] ?? '',
      avatarUrl: json['avatar'] ?? '',
      unreadCount: json['unread'] ?? 0,
    );
  }

  /// Пример списка чатов
  static List<Chat> getSampleList() {
    return [
      Chat(
        id: '1',
        name: 'Александр',
        lastMessage: 'Когда можно посмотреть квартиру?',
        time: '12:30',
        avatarUrl: 'https://picsum.photos/100/100?random=10',
        unreadCount: 2,
      ),
      Chat(
        id: '2',
        name: 'Мария',
        lastMessage: 'Отлично, договорились!',
        time: '10:15',
        avatarUrl: 'https://picsum.photos/100/100?random=11',
        unreadCount: 0,
      ),
      Chat(
        id: '3',
        name: 'Иван',
        lastMessage: 'Цена можно ниже?',
        time: 'Вчера',
        avatarUrl: 'https://picsum.photos/100/100?random=12',
        unreadCount: 0,
      ),
    ];
  }
}
