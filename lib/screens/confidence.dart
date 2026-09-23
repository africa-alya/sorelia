import 'package:flutter/material.dart';
import 'package:sorelia/screens/connexion.dart';

class ConfidencePage extends StatelessWidget {
  const ConfidencePage({super.key});

  // Couleurs réutilisées dans la page
  static const Color primaryDark = Color(0xFF1E293B);
  static const Color accentPurple = Color(0xFFEDE9FE);
  static const Color iconPurple = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Ta confidentialité",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              // Cartes d'information
              const Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      _InfoCard(
                        icon: Icons.lock_outline,
                        title: 'Données locales',
                        description: 'Tes notes, ta moyenne et ton emploi du temps restent enregistrés uniquement sur ce téléphone.',
                      ),
                      SizedBox(height: 16),
                      _InfoCard(
                        icon: Icons.shield_outlined,
                        title: 'Zéro internet requis',
                        description: 'L\'application fonctionne à 100% hors ligne. Aucune donnée n\'est envoyée à des serveurs externes.',
                      ),
                      SizedBox(height: 16),
                      _InfoCard(
                        icon: Icons.delete_outline,
                        title: 'Contrôle total',
                        description: 'Tu peux supprimer définitivement toutes les données de l\'application en un clic à tout moment.',
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Bouton d'action en bas
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const ConnexionPage()),
                    (route) => false,
                  ),
                  child: const Text(
                    'J\'ai compris',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: ConfidencePage.accentPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ConfidencePage.iconPurple, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ConfidencePage.primaryDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
