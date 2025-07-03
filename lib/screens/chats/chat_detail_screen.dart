import 'package:flutter/material.dart';
import '../../models/message.dart';
import '../../services/chat_service.dart';
import '../../widgets/chats/chat_bubble.dart';
import '../../widgets/chats/chat_input_field.dart';

class ChatDetailScreen extends StatefulWidget {
  final String currentUserId;
  final String contactId;
  final String contactName;

  const ChatDetailScreen({
    super.key,
    required this.currentUserId,
    required this.contactId,
    required this.contactName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ChatService _chatService = ChatService();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = _chatService.getMessagesBetween(widget.currentUserId, widget.contactId);
  }

  void _handleSend(String content, MessageType type) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: widget.currentUserId,
      receiverId: widget.contactId,
      content: content,
      type: type,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(message);
    });

    _chatService.addMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contactName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message,
                  isMe: message.senderId == widget.currentUserId,
                );
              },
            ),
          ),
          ChatInputField(onSend: _handleSend),
        ],
      ),
    );
  }
}
