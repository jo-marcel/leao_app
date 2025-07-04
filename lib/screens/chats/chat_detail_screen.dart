import 'package:flutter/material.dart';
import '../../models/message.dart';
import '../../services/chat_service.dart';
import '../../widgets/chats/chat_bubble.dart';
import '../../widgets/chats/chat_input_field.dart';

class ChatDetailScreen extends StatefulWidget {
  final String currentUserId;
  final String contactId;
  final String contactName;
  final String? contactPhotoUrl; // optionnel

  const ChatDetailScreen({
    super.key,
    required this.currentUserId,
    required this.contactId,
    required this.contactName,
    this.contactPhotoUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages =
        _chatService.getMessagesBetween(widget.currentUserId, widget.contactId);
    // scroll automatique après le build
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
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
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (widget.contactPhotoUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(widget.contactPhotoUrl!),
              )
            else
              const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Text(widget.contactName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
