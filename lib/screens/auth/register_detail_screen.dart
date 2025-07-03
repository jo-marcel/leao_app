import 'package:flutter/material.dart';

class RegisterDetailScreen extends StatefulWidget {
  const RegisterDetailScreen({super.key});

  @override
  State<RegisterDetailScreen> createState() => _RegisterDetailScreenState();
}

class _RegisterDetailScreenState extends State<RegisterDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  String? startYear;
  String? endYear;
  String personalDesc = '';
  String? postBacType;
  String? prepType;
  String postBacSchool = '';
  String location = '';

  Map<String, String> grades = {
    'Maths': '',
    'Physique': '',
    'Français': '',
    'Anglais': '',
    'Philosophie': '',
    'SVT': '',
  };

  final Color mainColor = const Color(0xFF003399);

  @override
  Widget build(BuildContext context) {
    final years = List.generate(15, (i) => (2010 + i).toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Compléter mon profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Parcours au lycée', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildDropdown('Année début', startYear, years, (val) => setState(() => startYear = val))),
                  const SizedBox(width: 12),
                  Expanded(child: _buildDropdown('Année fin', endYear, years, (val) => setState(() => endYear = val))),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Décris ton parcours au lycée',
                hint: 'Ex : 3 années géniales en S...',
                maxLines: 3,
                onChanged: (val) => personalDesc = val,
              ),
              const SizedBox(height: 24),
              const Text('Études post-bac', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildRadioGroup(['LMD', 'Cycle Ingénieur', 'Médecine'], postBacType, (val) => setState(() => postBacType = val)),
              if (postBacType == 'Cycle Ingénieur') ...[
                const SizedBox(height: 12),
                _buildRadioGroup(['Prépa scientifique', 'Prépa éco'], prepType, (val) => setState(() => prepType = val)),
              ],
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Nom de ton école post-bac',
                hint: 'Ex : INPHB, Centrale Nantes...',
                onChanged: (val) => postBacSchool = val,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Où vis-tu actuellement ?',
                hint: 'Ex : France, Côte d\'Ivoire...',
                onChanged: (val) => location = val,
              ),
              const SizedBox(height: 24),
              const Text('Notes au bac', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...grades.keys.map((subject) => _buildGradeField(subject)),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Envoyer les données au backend
                    }
                  },
                  child: const Text('Enregistrer', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? selected, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: items.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
      onChanged: onChanged,
      validator: (val) => val == null ? 'Champ requis' : null,
    );
  }

  Widget _buildTextField({required String label, String? hint, int maxLines = 1, required Function(String) onChanged}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      validator: (val) => val == null || val.isEmpty ? 'Champ requis' : null,
    );
  }

  Widget _buildGradeField(String subject) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Note en $subject',
          hintText: 'Ex : 15',
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (val) => grades[subject] = val,
        validator: (val) => val == null || val.isEmpty ? 'Requis' : null,
      ),
    );
  }

  Widget _buildRadioGroup(List<String> options, String? selected, Function(String) onChanged) {
    return Column(
      children: options.map((opt) {
        return RadioListTile(
          title: Text(opt),
          value: opt,
          groupValue: selected,
          activeColor: mainColor,
          onChanged: (val) => onChanged(val!),
        );
      }).toList(),
    );
  }
}
