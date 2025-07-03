import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;

  const PostCard({
    super.key,
    required this.username,
    required this.content,
    this.imageUrl,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_formatTimestamp(timestamp)),
          ),
          if (imageUrl != null)
            Image.network(imageUrl!, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(content),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}