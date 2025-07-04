// my_profile_screen.dart : vue stylisée de son propre profil (insta-style) + bouton modifier

import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'edit_profile_screen.dart';

class MyProfileScreen extends StatelessWidget {
  final UserModel user;
  const MyProfileScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfileScreen(user: user),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoUrl ?? ''),
            ),
            const SizedBox(height: 12),
            Text(user.fullName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(user.location ?? '',
                style: const TextStyle(color: Colors.grey)),
            Text(user.specialisation ?? ''),
            const SizedBox(height: 12),
            Text(user.bio ?? "Aucune bio pour le moment..."),
            const SizedBox(height: 12),
            Text(user.profileDescription ?? ''),
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
                      // Naviguer vers le détail de la publication
                    },
                    child: Image.network(
                      post.mediaUrls.isNotEmpty
                          ? post.mediaUrls.first
                          : 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
