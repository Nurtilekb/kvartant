import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/chat.dart';

/// Элемент списка чатов
class ChatListItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback? onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.lg, vertical: AppSizes.xs),
        padding: EdgeInsets.all(AppSizes.md),
        decoration: AppDecorations.card,
        child: Row(
          children: [
            // Аватар
            CircleAvatar(
              radius: AppSizes.iconXl,
              backgroundImage: NetworkImage(chat.avatarUrl),
              onBackgroundImageError: (_, __) {},
              child: chat.avatarUrl.isEmpty ? Icon(Icons.person, size: AppSizes.iconLg, color: AppColors.grey400) : null,
            ),
            SizedBox(width: AppSizes.md),
            // Информация
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chat.name, style: AppTextStyles.subtitle),
                      Text(chat.time, style: AppTextStyles.caption),
                    ],
                  ),
                  SizedBox(height: AppSizes.xs),
                  Row(
                    children: [
                      Expanded(child: Text(chat.lastMessage, style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                          child: Text('${chat.unreadCount}', style: TextStyle(color: AppColors.white, fontSize: AppSizes.textSm)),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
