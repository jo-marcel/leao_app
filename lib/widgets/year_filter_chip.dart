import 'package:flutter/material.dart';

class YearFilterChip extends StatelessWidget {
  final String year;
  final bool isSelected;
  final VoidCallback onSelected;

  const YearFilterChip({
    super.key,
    required this.year,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(year),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        selectedColor: Colors.indigo,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
