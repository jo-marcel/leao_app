import 'post_model.dart';

class UserModel {
  final String nom;
  final String prenom;
  final String dateNaissance;
  final String matricule;
  final String motDePasse;

  // Champs facultatifs ajoutés pour le profil
  final String? photoUrl;
  final String? bio;
  final String? specialisation;
  final String? location;
  final String? profileDescription;
  final List<PostModel> posts;

  UserModel({
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.matricule,
    required this.motDePasse,
    this.photoUrl,
    this.bio,
    this.specialisation,
    this.location,
    this.profileDescription,
    this.posts = const [],
  });

  /// Nom complet
  String get fullName => '$prenom $nom';

  /// Identifiant unique pour comparaison
  String get id => matricule;

  factory UserModel.empty() {
    return UserModel(
      nom: '',
      prenom: '',
      dateNaissance: '',
      matricule: '',
      motDePasse: '',
    );
  }

  bool get isEmpty =>
      nom.isEmpty &&
      prenom.isEmpty &&
      dateNaissance.isEmpty &&
      matricule.isEmpty &&
      motDePasse.isEmpty;

  bool get isNotEmpty => !isEmpty;
}
