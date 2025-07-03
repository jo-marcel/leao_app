class Alumni {
  final String id;
  final String firstName;
  final String lastName;
  final String matricule;
  final DateTime birthDate;
  final String? location;
  final String? profilePhotoPath;
  final String? postBacPath;
  final String? specialisation;
  final Map<String, double>? terminaleGrades;

  Alumni({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.matricule,
    required this.birthDate,
    this.location,
    this.profilePhotoPath,
    this.postBacPath,
    this.terminaleGrades,
    this.specialisation ,
  });
}