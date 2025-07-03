import 'package:flutter/material.dart';
import '../../models/contact.dart';
import '../../services/chat_service.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  final ChatService chatService = ChatService();

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String demoUserId = 'user_demo';
    final List<Contact> recentContacts = chatService.getRecentContacts(demoUserId);

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView.builder(
        itemCount: recentContacts.length,
        itemBuilder: (context, index) {
          final contact = recentContacts[index];
          final lastMessage = chatService.getLastMessageBetween(demoUserId, contact.id);

          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(contact.name),
            subtitle: Text(
              lastMessage?.content ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(
                  currentUserId: demoUserId,
                  contactId: contact.id,
                  contactName: contact.name,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
