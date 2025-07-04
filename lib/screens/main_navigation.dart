import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'alumni_screen.dart';
import 'info_screen.dart';
import './chats/chat_list_screen.dart';
import 'necro_screen.dart';
import 'profile_screen.dart';
import '../models/user_model.dart'; // <== pour accéder à UserModel

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // ✅ Simuler l’utilisateur connecté
  final UserModel currentUser = UserModel(
    nom: 'Kouadio',
    prenom: 'Marc',
    dateNaissance: '2002-03-12',
    matricule: 'BAC2020XK23',
    motDePasse: '********',
    photoUrl: 'https://example.com/photo.jpg',
    specialisation: 'Informatique / IA',
    location: 'France',
    bio: 'Étudiant passionné d’IA et ancien du lycée.',
    profileDescription: 'Profil scientifique avec un bon niveau en langues.',
    posts: const [], // ou tu ajoutes de vrais PostModel
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const AlumniScreen(),
      const InfoScreen(),
      ChatListScreen(),
      const NecroScreen(),
      ProfileScreen(
        viewedUser: currentUser,
        currentUser: currentUser,
      ),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.indigo[900],
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Anciens',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: 'Infos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Nécrologie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
