import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:_kvartant/models/chat.dart';
import 'package:_kvartant/widgets/chat_list_item.dart';

/// Вкладка Чаты
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Chat> chats = Chat.getSampleList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Чаты',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListItem(
            chat: chat,
            onTap: () {
              // Переход к чату
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Открыть чат с ${chat.name}')),
              );
            },
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF54B435),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
