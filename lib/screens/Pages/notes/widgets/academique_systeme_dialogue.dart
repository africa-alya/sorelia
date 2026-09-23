import 'package:flutter/material.dart';

enum AcademicSystem { trimester, semester }

class AcademicSystemDialog extends StatelessWidget {
  final Function(AcademicSystem system) onSystemSelected;

  const AcademicSystemDialog({
    super.key,
    required this.onSystemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school_rounded, size: 48, color: Color(0xFF14284B)),
            const SizedBox(height: 12),
            const Text(
              'Système d\'évaluation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Comment fonctionne votre année scolaire ?',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              leading: const Icon(Icons.looks_3_outlined, color: Color(0xFF14284B)),
              title: const Text('Trimestres'),
              subtitle: const Text('Trimestre 1, 2, 3'),
              onTap: () {
                onSystemSelected(AcademicSystem.trimester);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              leading: const Icon(Icons.looks_two_outlined, color: Color(0xFF14284B)),
              title: const Text('Semestres'),
              subtitle: const Text('Semestre 1, 2'),
              onTap: () {
                onSystemSelected(AcademicSystem.semester);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}