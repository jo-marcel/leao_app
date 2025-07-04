import 'package:flutter/material.dart';
import '../../../models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails de la publication')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.authorName,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(post.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (post.mediaUrls.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.mediaUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.network(
                        post.mediaUrls[index],
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            Text('Publié le : ${post.timestamp.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
