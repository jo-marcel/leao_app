class Post {
  final String id;
  final String authorId;
  final String content;
  final List<String> mediaPaths; // ← Ce champ est important
  final DateTime createdAt;

  Post({
    required this.id,
    required this.authorId,
    required this.content,
    required this.mediaPaths,
    required this.createdAt,
  });
}
