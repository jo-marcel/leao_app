import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/alumni.dart';

class AlumniScreen extends StatefulWidget {
  const AlumniScreen({super.key});

  @override
  State<AlumniScreen> createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  final TextEditingController _searchController = TextEditingController();
  final UserService _userService = UserService();
  String _searchTerm = '';
  String? _selectedYear;
  String? _selectedSpec;
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    final allUsers = _userService.getAllUsers();
    final filteredUsers = allUsers.where((user) {
      final matchesSearch = user.firstName.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          user.lastName.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          (user.postBacPath?.toLowerCase().contains(_searchTerm.toLowerCase()) ?? false) ||
          (user.location?.toLowerCase().contains(_searchTerm.toLowerCase()) ?? false);

      final matchesYear = _selectedYear == null || user.postBacPath?.contains(_selectedYear!) == true;
      final matchesSpec = _selectedSpec == null || user.specialisation?.contains(_selectedSpec!) == true;
      final matchesCountry = _selectedCountry == null || user.location?.contains(_selectedCountry!) == true;

      return matchesSearch && matchesYear && matchesSpec && matchesCountry;
    }).toList();

    final Map<String, List<Alumni>> groupedByYear = {};
    for (final user in filteredUsers) {
      final year = user.postBacPath?.replaceAll(RegExp(r'[^0-9]'), '') ?? 'Inconnu';
      groupedByYear.putIfAbsent(year, () => []).add(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Anciens"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher par nom, école, pays...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onChanged: (val) => setState(() => _searchTerm = val),
            ),
          ),
          Expanded(
            child: groupedByYear.isEmpty
                ? const Center(child: Text("Aucun ancien trouvé."))
                : ListView(
                    children: groupedByYear.entries.map((entry) {
                      final year = entry.key;
                      final users = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text("Ancien$year", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 90,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                itemCount: users.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 12),
                                itemBuilder: (_, index) {
                                  final user = users[index];
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: user.profilePhotoPath != null ? AssetImage(user.profilePhotoPath!) : null,
                                        child: user.profilePhotoPath == null ? const Icon(Icons.person) : null,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(user.firstName, style: const TextStyle(fontSize: 12))
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          )
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Filtrer les anciens", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: const InputDecoration(labelText: "Année du Bac"),
                items: ['2022', '2023', '2024'].map((year) {
                  return DropdownMenuItem(value: year, child: Text("Promotion $year"));
                }).toList(),
                onChanged: (value) => setState(() => _selectedYear = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedSpec,
                decoration: const InputDecoration(labelText: "Spécialisation"),
                items: ['IA', 'Réseaux', 'Finance', 'Management'].map((spec) {
                  return DropdownMenuItem(value: spec, child: Text(spec));
                }).toList(),
                onChanged: (value) => setState(() => _selectedSpec = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(labelText: "Pays de résidence"),
                items: ['Côte d’Ivoire', 'France', 'Canada', 'USA', 'Inde', 'chypre' ,'chine','Maroc', 'Russie', 'Tunisie','Sénégal','Afrique du sud'].map((country) {
                  return DropdownMenuItem(value: country, child: Text(country));
                }).toList(),
                onChanged: (value) => setState(() => _selectedCountry = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Appliquer les filtres"),
              ),
            ],
          ),
        );
      },
    );
  }
}
