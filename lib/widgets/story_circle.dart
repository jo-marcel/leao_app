import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String? label;
  final String? imageUrl;

  const StoryCircle({super.key, this.label, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.indigo, width: 2),
            image: imageUrl != null
                ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                : null,
            color: imageUrl == null ? Colors.grey[300] : null,
          ),
          child: imageUrl == null ? const Icon(Icons.add, size: 30) : null,
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(label!, style: const TextStyle(fontSize: 12)),
          ),
      ],
    );
  }
}
