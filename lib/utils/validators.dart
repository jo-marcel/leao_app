class Validators {
  static String? required(String? value) {
    return (value == null || value.isEmpty) ? 'Ce champ est requis' : null;
  }

  static String? validateMatricule(String? value) {
    if (value == null || value.isEmpty) return 'Matricule requis';
    if (value.length < 5) return 'Matricule trop court';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe requis';
    if (value.length < 6) return 'Minimum 6 caractères';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nom requis';
    if (value.length < 2) return 'Nom trop court';
    return null;
  }
}
