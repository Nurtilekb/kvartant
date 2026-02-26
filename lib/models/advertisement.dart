/// Модель объявления
class Advertisement {
  final String id;
  final String title;
  final String address;
  final String price;
  final int rooms;
  final String area;
  final String imageUrl;
  final String? description;
  final String type; // квартира, дом, комната, студия
  bool isFavorite;

  Advertisement({
    required this.id,
    required this.title,
    required this.address,
    required this.price,
    required this.rooms,
    required this.area,
    required this.imageUrl,
    this.description,
    this.type = 'Квартира',
    this.isFavorite = false,
  });

  /// Создание объявления из JSON
  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] ?? '',
      rooms: json['rooms'] ?? 0,
      area: json['area'] ?? '',
      imageUrl: json['image'] ?? '',
      description: json['description'],
      type: json['type'] ?? 'Квартира',
    );
  }

  /// Преобразование в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'price': price,
      'rooms': rooms,
      'area': area,
      'image': imageUrl,
      'description': description,
      'type': type,
    };
  }

  /// Пример списка объявлений (для теста)
  static List<Advertisement> getSampleList() {
    return [
      Advertisement(
        id: '1',
        title: 'Квартира в центре',
        address: 'ул. Ленина, 10',
        price: '50 000 ₽/мес',
        rooms: 2,
        area: '60 м²',
        imageUrl: 'https://picsum.photos/400/300?random=1',
      ),
      Advertisement(
        id: '2',
        title: 'Студия у метро',
        address: 'ул. Пушкина, 5',
        price: '35 000 ₽/мес',
        rooms: 1,
        area: '35 м²',
        imageUrl: 'https://picsum.photos/400/300?random=2',
      ),
      Advertisement(
        id: '3',
        title: '3-комнатная квартира',
        address: 'пр. Мира, 25',
        price: '75 000 ₽/мес',
        rooms: 3,
        area: '90 м²',
        imageUrl: 'https://picsum.photos/400/300?random=3',
      ),
      Advertisement(
        id: '4',
        title: 'Элитная квартира',
        address: 'ул. Горького, 15',
        price: '120 000 ₽/мес',
        rooms: 4,
        area: '150 м²',
        imageUrl: 'https://picsum.photos/400/300?random=4',
      ),
      Advertisement(
        id: '5',
        title: 'Квартира с ремонтом',
        address: 'ул. Советская, 8',
        price: '45 000 ₽/мес',
        rooms: 2,
        area: '55 м²',
        imageUrl: 'https://picsum.photos/400/300?random=5',
      ),
    ];
  }
}
