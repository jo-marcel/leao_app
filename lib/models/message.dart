enum MessageType {
  text,
  image,
  audio,
  file,
}

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content; // texte ou chemin du fichier média
  final MessageType type;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.timestamp,
  });
}