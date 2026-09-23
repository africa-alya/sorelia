import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/matiere.dart';
import 'package:sorelia/domain/entities/note.dart';
import 'package:sorelia/domain/entities/json.dart';



class MatiereNoteSection extends StatelessWidget {
  final int eleveId;
  final String classeEleve; 
  final String serieEleves;
  final List<Matter> matieres;
  final String selectedPeriod;
  final Function(Matter matiere) onAddNotePressed;
  final VoidCallback onMatiereAdded; 

  const MatiereNoteSection({
    super.key,
    required this.matieres,
    required this.selectedPeriod,
    required this.onAddNotePressed,
    required this.onMatiereAdded,
    required this.eleveId,
    required this.classeEleve,
    required this.serieEleves,
  });

  /// Charge le JSON assets/matieres.json et filtre selon le niveau et la série
  Future<List<MatiereReference>> _chargerMatieresFiltrees({
    required String niveau,
    required String serie,
  }) async {
    final String rawJson = await rootBundle.loadString('assets/coefficients/coefficientref.json');
    final List<dynamic> list = json.decode(rawJson);

    return list
        .map((e) => MatiereReference.fromJson(e))
        .where((m) => m.niveau == niveau && m.serie == serie)
        .toList();
  }

  /// Ouvre le catalogue des matières disponibles
  void _afficherCatalogueMatieres(BuildContext context) async {
    
    final String niveauEleve = classeEleve; 
    final String serieEleve = serieEleves;

    final matieresDisponibles = await _chargerMatieresFiltrees(
      niveau: niveauEleve,
      serie: serieEleve,
    );

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Catalogue des matières",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14284B),
                      fontFamily: "Montserrat",
                    ),
                  ),
                  Text(
                    "Niveau $niveauEleve • Série $serieEleve",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      itemCount: matieresDisponibles.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = matieresDisponibles[index];
                        
                        // Vérifie si la matière a déjà été ajoutée par l'élève
                        final dejaAjoutee = matieres.any(
                          (m) => m.nom.toLowerCase() == item.matiere.toLowerCase(),
                        );

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.matiere,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF14284B),
                            ),
                          ),
                          subtitle: Text("Coefficient ${item.coefficient}"),
                          trailing: dejaAjoutee
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Ajoutée",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF14284B),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    _confirmerAjout(context, item);
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Boîte de dialogue de confirmation avant enregistrement Drift
  void _confirmerAjout(BuildContext context, MatiereReference ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Ajouter ${ref.matiere} ?"),
        content: Text(
          "Voulez-vous ajouter la matière \"${ref.matiere}\" (Coeff ${ref.coefficient}) à vos matières ?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Annuler", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF14284B),
            ),
            child: const Text("Ajouter", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Insertion dans la BDD Drift
      final newMatiere = Matter(
        nom: ref.matiere,
        serie: ref.serie, 
        eleveId: eleveId,
        coefficient: ref.coefficient.toDouble(),
      );
      
      final idCree = await DatabaseHelper.instance.createMatiere(newMatiere);

      if (context.mounted && idCree > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${ref.matiere} a été ajoutée avec succès !"),
            backgroundColor: Colors.green[700],
          ),
        );
        // Notifier la page parente pour recharger la liste des matières
        onMatiereAdded();
      }
    }
  }

  /// En-tête avec titre et bouton "+ Ajouter" toujours visible
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mes Matières',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF14284B),
              fontFamily: "Montserrat",
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _afficherCatalogueMatieres(context),
            icon: const Icon(Icons.add, size: 18, color: Colors.white),
            label: const Text(
              "Ajouter",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF14284B),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. En-tête toujours présent (permet d'ajouter d'autres matières à tout moment)
        _buildHeader(context),
        const SizedBox(height: 12),

        // 2. Affichage si aucune matière n'a encore été ajoutée
        if (matieres.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Icon(Icons.menu_book_rounded, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'Aucune matière disponible',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cliquez sur le bouton "Ajouter" ci-dessus pour sélectionner vos matières.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          )
        else
          // 3. Liste des cartes de matières
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: matieres.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final matiere = matieres[index];

              return FutureBuilder<List<Score>>(
                // Récupère uniquement les notes correspondant au trimestre/semestre actif
                future: DatabaseHelper.instance.getNotesPourMatiere(
                  matiere.id!,
                  periode: selectedPeriod,
                ),
                builder: (context, snapshot) {
                  final notes = snapshot.data ?? [];
                  final isLoading =
                      snapshot.connectionState == ConnectionState.waiting;

                  return MatiereCard(
                    matiere: matiere,
                    notes: notes,
                    isLoading: isLoading,
                    onAddNote: () => onAddNotePressed(matiere),
                  );
                },
              );
            },
          ),
      ],
    );
  }
}

/// Carte individuelle d'affichage d'une matière et de ses notes
class MatiereCard extends StatelessWidget {
  final Matter matiere;
  final List<Score> notes;
  final bool isLoading;
  final VoidCallback onAddNote;

  const MatiereCard({
    super.key,
    required this.matiere,
    required this.notes,
    required this.isLoading,
    required this.onAddNote,
  });

  double? get _moyenneMatiere {
    if (notes.isEmpty) return null;
    final sum = notes.fold<double>(0, (prev, n) => prev + n.valeur);
    return sum / notes.length;
  }

  @override
  Widget build(BuildContext context) {
    final moyenne = _moyenneMatiere;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne 1 : Nom de la matière + Badge Coefficient
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  matiere.nom,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF14284B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Coef ${matiere.coefficient}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Ligne 2 : Liste des notes + Bouton/Moyenne
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : notes.isEmpty
                        ? Text(
                            'Aucune note',
                            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                          )
                        : Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: notes.map((note) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF14284B).withAlpha(15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  note.valeur.toStringAsFixed(
                                    note.valeur.truncateToDouble() == note.valeur ? 0 : 2,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF14284B),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
              ),
              const SizedBox(width: 8),

              // Action pour ajouter une note ou affichage de la moyenne
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF14284B)),
                onPressed: onAddNote,
              ),

              Text(
                moyenne != null ? '${moyenne.toStringAsFixed(2)} / 20' : '-- / 20',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: moyenne != null && moyenne >= 10
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}