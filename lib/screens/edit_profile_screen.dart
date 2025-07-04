import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../widgets/stat_card.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({required this.user, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _startYear = TextEditingController();
  final TextEditingController _endYear = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _schoolName = TextEditingController();
  final TextEditingController _schoolCity = TextEditingController();
  final TextEditingController _schoolDuration = TextEditingController();

  String postBacChoice = "";
  String cycleType = "";
  String specialisation = "";
  String selectedLocation = "";

  Map<String, double> bacGrades = {
    "Maths": 14,
    "Physique": 15,
    "SVT": 13,
    "Français": 12,
    "Anglais": 16,
    "Philo": 10,
  };

  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _profileImage = File(picked.path));
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permission refusée pour accéder à la galerie')),
      );
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil mis à jour !")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Pré-remplir les champs si souhaité
    _bio.text = "";
    _startYear.text = "";
    _endYear.text = "";
    _description.text = "";
    _schoolName.text = "";
    _schoolCity.text = "";
    _schoolDuration.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifier mon profil")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bio,
                decoration:
                    const InputDecoration(labelText: "Bio (facultatif)"),
              ),
              const SizedBox(height: 12),
              Text("Année de début au lycée"),
              TextFormField(
                  controller: _startYear,
                  validator: (v) => v == null || v.isEmpty ? 'Requis' : null),
              const SizedBox(height: 12),
              Text("Année de fin au lycée"),
              TextFormField(
                  controller: _endYear,
                  validator: (v) => v == null || v.isEmpty ? 'Requis' : null),
              const SizedBox(height: 12),
              Text("Comment s'est passé ton parcours au lycée ?"),
              TextFormField(
                controller: _description,
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Ton ressenti..."),
              ),
              const SizedBox(height: 16),
              Text("Études post-bac"),
              DropdownButtonFormField<String>(
                value: postBacChoice.isEmpty ? null : postBacChoice,
                items: ["LMD", "Cycle ingénieur", "Médecine"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => postBacChoice = val ?? ""),
                validator: (v) => v == null ? 'Requis' : null,
              ),
              if (postBacChoice == "Cycle ingénieur") ...[
                const SizedBox(height: 12),
                Text("Type de prépa (Science ou Eco)"),
                DropdownButtonFormField<String>(
                  value: cycleType.isEmpty ? null : cycleType,
                  items: ["Science", "Eco"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => cycleType = val ?? ""),
                  validator: (v) => v == null ? 'Requis' : null,
                ),
                const SizedBox(height: 12),
                Text("Nom de l'école"),
                TextFormField(controller: _schoolName),
                const SizedBox(height: 12),
                Text("Ville de l'école"),
                TextFormField(controller: _schoolCity),
                const SizedBox(height: 12),
                Text("Durée de formation (en années)"),
                TextFormField(
                    controller: _schoolDuration,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 12),
                Text("Spécialisation"),
                DropdownButtonFormField<String>(
                  value: specialisation.isEmpty ? null : specialisation,
                  items: ["IA", "Réseaux", "Finance", "Management"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => specialisation = val ?? ""),
                  validator: (v) => v == null ? 'Requis' : null,
                ),
              ],
              const SizedBox(height: 16),
              Text("Localisation actuelle (pays)"),
              DropdownButtonFormField<String>(
                value: selectedLocation.isEmpty ? null : selectedLocation,
                items: [
                  "Côte d'Ivoire",
                  "France",
                  "USA",
                  "Canada",
                  "Inde",
                  "Chypre",
                  "Chine",
                  "Maroc",
                  "Russie",
                  "Tunisie",
                  "Sénégal",
                  "Afrique du Sud"
                ]
                    .map((country) =>
                        DropdownMenuItem(value: country, child: Text(country)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => selectedLocation = val ?? ""),
                validator: (v) => v == null ? 'Requis' : null,
              ),
              const SizedBox(height: 24),
              const Text("Notes au bac (modifiables)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Column(
                children: bacGrades.keys.map((subject) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(subject)),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue:
                                bacGrades[subject]?.toStringAsFixed(1),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                            ),
                            onChanged: (val) {
                              final parsed =
                                  double.tryParse(val.replaceAll(',', '.'));
                              if (parsed != null &&
                                  parsed >= 0 &&
                                  parsed <= 20) {
                                setState(() => bacGrades[subject] = parsed);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text("Visualisation (Stats Bac)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: bacGrades.entries.map((e) {
                  return StatCard(
                    title: e.key,
                    value: e.value,
                    icon: Icons.bar_chart,
                    color: Colors.teal,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Center(child: Text("Enregistrer le profil")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
