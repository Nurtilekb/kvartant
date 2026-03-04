import 'package:flutter/material.dart';
import 'package:_kvartant/core/app_theme.dart';
import 'package:_kvartant/models/chat.dart';
import 'package:_kvartant/widgets/chat_list_item.dart';

/// Вкладка Чаты
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Chat> chats = Chat.getSampleList();

    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('Чаты', style: AppTextStyles.title),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListItem(
            chat: chat,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Открыть чат с ${chat.name}')),
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: AppSizes.bottomNavHeight + AppSizes.lg),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          heroTag: 'add_chat',
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
