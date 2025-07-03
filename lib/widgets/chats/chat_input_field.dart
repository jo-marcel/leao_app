import 'package:flutter/material.dart';
import '../../models/message.dart';

class ChatInputField extends StatefulWidget {
  final Function(String content, MessageType type) onSend;

  const ChatInputField({super.key, required this.onSend});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text, MessageType.text);
      _controller.clear();
    }
  }

  void _handleMediaSend(MessageType type) {
    // Pour l'instant on envoie un faux chemin. Remplacer par un vrai sélecteur de média.
    widget.onSend("/fake/path/to/media.${type.name}", type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () => _handleMediaSend(MessageType.file),
            ),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: () => _handleMediaSend(MessageType.image),
            ),
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () => _handleMediaSend(MessageType.audio),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Écrire un message...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}