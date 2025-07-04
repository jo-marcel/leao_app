// profile_screen.dart : point d'entrée unique

import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'my_profile_screen.dart';
import 'user_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel viewedUser;
  final UserModel currentUser;

  const ProfileScreen(
      {required this.viewedUser, required this.currentUser, super.key});

  @override
  Widget build(BuildContext context) {
    if (viewedUser.id == currentUser.id) {
      return MyProfileScreen(user: currentUser);
    } else {
      return UserProfileScreen(user: viewedUser);
    }
  }
}
