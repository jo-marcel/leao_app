import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../screens/chats/chat_detail_screen.dart';
import '../../screens/posts/post_detail_screen.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel user;
  const UserProfileScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl?.isNotEmpty == true ? user.photoUrl! : null;
    final location = user.location ?? "Localisation non précisée";
    final specialisation = user.specialisation ?? "Spécialisation non précisée";
    final bio = user.bio ?? "Pas de bio disponible...";
    final description = user.profileDescription ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailScreen(
                    currentUserId: "monId", // remplacez dynamiquement
                    contactId: user.id,
                    contactName: user.fullName,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: photo != null ? NetworkImage(photo) : null,
              child: photo == null ? const Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(height: 12),
            Text(user.fullName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(location, style: const TextStyle(color: Colors.grey)),
            Text(specialisation),
            const SizedBox(height: 12),
            Text(bio),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Publications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: user.posts.length,
              itemBuilder: (context, index) {
                final post = user.posts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                  child: Image.network(post.mediaUrls.first, fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
