class PostModel {
  final String id;
  final String authorId;
  final String authorName;
  final String description;
  final List<String> mediaUrls;
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.description,
    required this.mediaUrls,
    required this.timestamp,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      description: json['description'] as String,
      mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'description': description,
      'mediaUrls': mediaUrls,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
