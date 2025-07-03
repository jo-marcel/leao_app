import '../models/alumni.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final Map<String, Alumni> _alumniDB = {}; // Simule une base de données

  void saveUser(Alumni user) {
    _alumniDB[user.matricule] = user;
  }

  Alumni? getUserByMatricule(String matricule) {
    return _alumniDB[matricule];
  }

  List<Alumni> getAllUsers() {
    return _alumniDB.values.toList();
  }

  List<Alumni> getUsersByBacYear(String year) {
    return _alumniDB.values
        .where((u) => u.terminaleGrades != null && u.terminaleGrades!.containsKey('bacYear') && u.terminaleGrades!['bacYear'].toString() == year)
        .toList();
  }
}