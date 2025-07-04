import '../models/message.dart';
import '../models/contact.dart';

class ChatService {
  final List<Message> _messages = [];

  ChatService() {
    _initFakeData();
  }

  void _initFakeData() {
    final message = Message(
      id: '1',
      senderId: 'alex',
      receiverId: 'brito',
      content: 'Salut Brito, bienvenue sur l’app des anciens élèves !',
      type: MessageType.text,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    );
    _messages.add(message);
  }

  void addMessage(Message message) {
    _messages.add(message);
  }

  List<Message> getMessagesBetween(String userId1, String userId2) {
    return _messages
        .where((m) =>
            (m.senderId == userId1 && m.receiverId == userId2) ||
            (m.senderId == userId2 && m.receiverId == userId1))
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  List<Contact> getRecentContacts(String userId) {
    final Map<String, Message> lastMessages = {};

    for (var m in _messages) {
      if (m.senderId == userId) {
        lastMessages[m.receiverId] = m;
      } else if (m.receiverId == userId) {
        lastMessages[m.senderId] = m;
      }
    }

    return lastMessages.entries.map((entry) {
      final contactId = entry.key;
      final name =
          contactId == 'alex' ? 'Alexandre Kouadio' : 'Utilisateur $contactId';
      return Contact(id: contactId, name: name);
    }).toList();
  }

  Message? getLastMessageBetween(String userId1, String userId2) {
    final messages = getMessagesBetween(userId1, userId2);
    return messages.isNotEmpty ? messages.last : null;
  }
}
