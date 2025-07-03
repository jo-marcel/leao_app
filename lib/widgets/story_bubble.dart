import 'package:flutter/material.dart';

class StoryBubble extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ImageProvider? image;
  final bool isNew;

  const StoryBubble({
    super.key,
    required this.label,
    required this.onTap,
    this.image,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: image,
                child: image == null ? const Icon(Icons.add, size: 28) : null,
              ),
              if (isNew)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.fiber_new, size: 12, color: Colors.white),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
