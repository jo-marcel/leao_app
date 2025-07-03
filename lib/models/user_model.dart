class UserModel {
  final String nom;
  final String prenom;
  final String dateNaissance;
  final String matricule;
  final String motDePasse;

  UserModel({
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.matricule,
    required this.motDePasse,
  });

  /// Factory method pour créer un utilisateur vide
  factory UserModel.empty() {
    return UserModel(
      nom: '',
      prenom: '',
      dateNaissance: '',
      matricule: '',
      motDePasse: '',
    );
  }

  /// Vérifie si l'utilisateur est vide
  bool get isEmpty =>
      nom.isEmpty &&
      prenom.isEmpty &&
      dateNaissance.isEmpty &&
      matricule.isEmpty &&
      motDePasse.isEmpty;

  /// Vérifie si l'utilisateur est rempli
  bool get isNotEmpty => !isEmpty;
}
