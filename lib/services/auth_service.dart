import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {
  final List<UserModel> _users = []; // Simule une base de données utilisateur

  Future<void> register({
    required String nom,
    required String prenom,
    required String dateNaissance,
    required String matricule,
    required String motDePasse,
    required BuildContext context,
  }) async {
    final existingUser = _users.any((user) => user.matricule == matricule);
    if (existingUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ce matricule existe déjà.')),
      );
      return;
    }

    final newUser = UserModel(
      nom: nom,
      prenom: prenom,
      dateNaissance: dateNaissance,
      matricule: matricule,
      motDePasse: motDePasse,
    );

    _users.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inscription réussie. Connectez-vous.')),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> login({
    required String matricule,
    required String motDePasse,
    required BuildContext context,
  }) async {
    final user = _users.firstWhere(
      (u) => u.matricule == matricule && u.motDePasse == motDePasse,
      orElse: () => UserModel.empty(),
    );

    if (user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matricule ou mot de passe incorrect.')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/main');
  }

  // Getter utile si besoin de lister les utilisateurs
  List<UserModel> get users => _users;
}