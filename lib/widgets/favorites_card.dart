import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/advertisement.dart';
import 'package:_kvartant/widgets/info_chip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Карточка объявления
class FavoritestCard extends StatelessWidget {
  final Advertisement advertisement;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const FavoritestCard({
    super.key,
    required this.advertisement,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdvertisementDetailPage(
                  advertisement: advertisement,
                ),
              ),
            );
          },
      child: Container(
        decoration: AppDecorations.card,
        // Добавляем ограничение максимальной ширины
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 32.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Важно! Занимаем только нужную высоту
          children: [
            // Изображение с кнопкой избранного
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusXl),
              ),
              child: SizedBox(
                height: 200.w,
                width: double.infinity,
                child: Stack(
                  fit: StackFit
                      .expand, // Растягиваем стек на всю доступную площадь
                  children: [
                    Hero(
                      tag: 'advertisement_image_${advertisement.id}',
                      child: Image.network(
                        advertisement.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.grey200,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: AppSizes.iconMd,
                                color: AppColors.grey400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Кнопка избранного
                    Positioned(
                      top: AppSizes.xs,
                      right: AppSizes.xs,
                      child: GestureDetector(
                        onTap: onFavorite,
                        child: Container(
                          padding: EdgeInsets.all(AppSizes.xs),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            advertisement.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: advertisement.isFavorite
                                ? AppColors.error
                                : AppColors.grey500,
                            size: AppSizes.iconSm,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Информация
            Padding(
              padding: EdgeInsets.all(AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Цена
                  Text(
                    advertisement.price,
                    style: AppTextStyles.pricetofavcard,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.xs),
                  // Название
                  Text(
                    advertisement.title,
                    style: AppTextStyles.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.xs),
                  // Адрес
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: AppSizes.iconSm,
                        color: AppColors.grey500,
                      ),
                      SizedBox(width: AppSizes.xs),
                      Expanded(
                        child: Text(
                          advertisement.address,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InfoChip(
                        icon: Icons.bed,
                        iconColor: AppColors.black,
                        label: '${advertisement.rooms}',
                        compact: true,
                      ),
                      SizedBox(width: AppSizes.xs),
                      InfoChip(
                        iconColor: AppColors.black,
                        icon: Icons.square_foot,
                        label: advertisement.area,
                        compact: true,
                      ),
                    ],
                  ),
                  // Характеристики
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// /// Страница деталей объявления
/// Страница деталей объявления
class AdvertisementDetailPage extends StatelessWidget {
  final Advertisement advertisement;

  const AdvertisementDetailPage({
    super.key,
    required this.advertisement,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали объявления'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              advertisement.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: advertisement.isFavorite ? AppColors.error : null,
            ),
            onPressed: () {
              // TODO: Добавить логику избранного
            },
          ),
        ],
      ),
      body: SafeArea(
        // Добавляем SafeArea для учета отступов системы
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Большое изображение
              Hero(
                tag: 'advertisement_image_${advertisement.id}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(AppSizes.radiusXl),
                    ),
                  ),
                  padding: EdgeInsets.all(10.w),
                  height: 300.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radiusXl),
                    ),
                    child: Image.network(
                      advertisement.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey200,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: AppSizes.iconLg,
                              color: AppColors.grey400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Цена
                    Text(
                      advertisement.price,
                      style: AppTextStyles.headline,
                    ),
                    SizedBox(height: AppSizes.sm),

                    // Название
                    Text(
                      advertisement.title,
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: AppSizes.md),

                    // Детальная информация
                    Card(
                      margin:
                          EdgeInsets.zero, // Убираем внешние отступы карточки
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.md),
                        child: Column(
                          children: [
                            _buildDetailRow(
                                Icons.bed, 'Комнат', '${advertisement.rooms}'),
                            _buildDetailRow(Icons.square_foot, 'Площадь',
                                advertisement.area),
                            _buildDetailRow(Icons.location_on, 'Адрес',
                                advertisement.address),
                            if (advertisement.description != null)
                              _buildDetailRow(Icons.description, 'Описание',
                                  advertisement.description!),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.md),

                    // Кнопка связи
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Добавить логику связи с продавцом
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Функция связи будет доступна скоро'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: AppSizes.md),
                        ),
                        child: Text(
                          'Связаться с продавцом',
                          style: AppTextStyles.button,
                        ),
                      ),
                    ),

                    // Добавляем дополнительный отступ снизу для удобства скролла
                    SizedBox(height: AppSizes.lg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSizes.iconMd,
            color: AppColors.primary,
          ),
          SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
