import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../widgets/story_bubble.dart';
import './story_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _postDescription = TextEditingController();
  List<File> _postMedia = [];
  final PostService _postService = PostService();

  bool _showBanner = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      if (mounted) setState(() => _showBanner = false);
    });
  }

  void _showPostDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nouvelle publication"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _postDescription,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: "Description de ta publication..."),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickPostMedia,
              icon: const Icon(Icons.image),
              label: const Text("Ajouter des médias (max 5)"),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: _postMedia
                  .map((file) => Image.file(file, width: 60, height: 60))
                  .toList(),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Annuler")),
          ElevatedButton(
            onPressed: () {
              final newPost = Post(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                authorId: "current_user_id", // à remplacer
                content: _postDescription.text,
                mediaPaths: _postMedia.map((e) => e.path).toList(),
                createdAt: DateTime.now(),
              );
              _postService.addPost(newPost);
              setState(() {
                _postDescription.clear();
                _postMedia.clear();
              });
              Navigator.pop(ctx);
            },
            child: const Text("Publier"),
          ),
        ],
      ),
    );
  }

  void _showStoryDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryViewer(
          mediaPaths: [
            'assets/stories/exemple.jpg',
            'assets/stories/logo_leao.jpeg'
          ],
          startIndex: 0,
          username: "Alex",
        ),
      ),
    );
  }

  Future<void> _pickPostMedia() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final picked = await picker.pickMultiImage();
      if (!mounted) return;
      if (picked.length > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('5 médias maximum autorisés.')),
        );
        return;
      }
      setState(() => _postMedia = picked.map((e) => File(e.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = _postService.getAllPosts();
    return Scaffold(
      appBar: AppBar(title: const Text("Accueil")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_showBanner)
            Container(
              color: Colors.orange[100],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: const [
                  Icon(Icons.warning_amber, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Veuillez compléter votre profil pour utiliser toutes les fonctionnalités.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

          // 🎯 Story Bar
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                StoryBubble(
                  label: "Toi",
                  image: null,
                  onTap: _showStoryDialog,
                  isNew: false,
                ),
                const SizedBox(width: 12),
                StoryBubble(
                  label: "Alex",
                  image: const AssetImage("assets/stories/exemple.jpg"),
                  onTap: _showStoryDialog,
                  isNew: true,
                ),
                const SizedBox(width: 12),
                StoryBubble(
                  label: "Mariam",
                  image: const AssetImage("assets/stories/logo_leao.jpeg"),
                  onTap: _showStoryDialog,
                  isNew: false,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 🎯 Champ de publication rapide
          Row(
            children: [
              GestureDetector(
                onTap: _showStoryDialog,
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.add, size: 28),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: _showPostDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text("Exprime-toi...",
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),

          // 📝 Liste des publications
          ...posts.map((post) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.content, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      if (post.mediaPaths.isNotEmpty)
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: post.mediaPaths.map((path) {
                            final file = File(path);
                            return file.existsSync()
                                ? Image.file(file, width: 80, height: 80)
                                : const SizedBox();
                          }).toList(),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        post.createdAt.toLocal().toString().split(".")[0],
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
