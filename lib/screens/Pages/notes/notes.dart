import 'package:flutter/material.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';
import 'package:sorelia/domain/entities/matiere.dart';

import 'widgets/academique_systeme_dialogue.dart';
import 'widgets/matiere_section.dart';

class NotePage extends StatefulWidget {
  final int eleveId;

  const NotePage({super.key, required this.eleveId});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Student? _eleve;
  double? _moyenneAffichee;
  List<Matter> _matieres = [];
  bool _loading = true;
  String _selectedPeriod = '';

  @override
  void initState() {
    super.initState();
    _charger(widget.eleveId);
  }

  List<String> _getPeriods(String? systeme) {
    if (systeme == 'SEMESTRE') {
      return ['Semestre 1', 'Semestre 2', 'Annuelle'];
    }
    return ['Trimestre 1', 'Trimestre 2', 'Trimestre 3', 'Annuelle'];
  }

  Future<void> _charger(int id, {bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() => _loading = true);
    }

    final eleve = await DatabaseHelper.instance.getEleveById(id);
    final periods = _getPeriods(eleve?.systemeAcademique);

    if (_selectedPeriod.isEmpty || !isRefreshing) {
      _selectedPeriod = periods.first;
    }

    // Récupération globale des matières
    final matieres = await DatabaseHelper.instance.getMatieres(id);
    final moyenne = await _calculerMoyenne(id, _selectedPeriod);

    if (!mounted) return;

    setState(() {
      _eleve = eleve;
      _matieres = matieres;
      _moyenneAffichee = moyenne;
      _loading = false;
    });

    // Si le système n'est pas encore défini, on affiche le dialogue
    if (eleve != null && eleve.systemeAcademique == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _afficherDialogueSysteme();
      });
    }
  }

  Future<double?> _calculerMoyenne(int id, String period) async {
    if (period == 'Annuelle') {
      return await DatabaseHelper.instance.getMoyenneAnnuelle(id);
    } else {
      return await DatabaseHelper.instance.getMoyenneGenerale(
        id,
        periode: period,
      );
    }
  }

  Future<void> _afficherDialogueSysteme() async {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AcademicSystemDialog(
        onSystemSelected: (system) {
          _sauvegarderSystemeScolaire(system);
        },
      ),
    );
  }

  Future<void> _sauvegarderSystemeScolaire(AcademicSystem system) async {
    final valeur = system == AcademicSystem.trimester
        ? 'TRIMESTRE'
        : 'SEMESTRE';

    await DatabaseHelper.instance.updateSystemeAcademique(
      widget.eleveId,
      valeur,
    );

    if (!mounted) return;

    await _charger(widget.eleveId, isRefreshing: true);
  }

  Future<void> _onPeriodSelected(String period) async {
    setState(() {
      _selectedPeriod = period;
    });
    await _recalculerDonnees();
  }

  Future<void> _recalculerDonnees() async {
    final moyenne = await _calculerMoyenne(widget.eleveId, _selectedPeriod);
    if (!mounted) return;
    setState(() {
      _moyenneAffichee = moyenne;
    });
  }

  Future<void> _refresh() async {
    await _charger(widget.eleveId, isRefreshing: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_eleve == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Sorélia"), centerTitle: true),
        body: const Center(child: Text("Élève non trouvé")),
      );
    }

    final systeme = _eleve?.systemeAcademique == 'SEMESTRE'
        ? AcademicSystem.semester
        : AcademicSystem.trimester;

    return Scaffold(
      appBar: AppBar(title: const Text("Sorélia"), centerTitle: true),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (_eleve?.systemeAcademique == null) ...[
                Card(
                  elevation: 0,
                  color: Colors.amber.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.amber.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.amber,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Système académique non sélectionné",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Veuillez choisir entre le système Semestriel ou Trimestriel pour afficher vos notes.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _afficherDialogueSysteme,
                          child: const Text("Configurer le système"),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                //  Contenu principal
                OverallAverageHeader(
                  academicSystem: systeme,
                  selectedPeriod: _selectedPeriod,
                  seriesLabel: _eleve?.serie ?? '',
                  moyenne: _moyenneAffichee,
                  onPeriodSelected: _onPeriodSelected,
                ),
                const SizedBox(height: 24),

                if (_selectedPeriod == 'Annuelle')
                  const VueAnnuellePlaceholder()
                else
                  MatiereNoteSection(
                    matieres: _matieres,
                    classeEleve: _eleve?.niveau ?? '', //
                    serieEleves: _eleve?.serie ?? '',
                    selectedPeriod: _selectedPeriod,
                    onAddNotePressed: (matiere) {
                      // Action d'ajout de note
                    },
                    eleveId: widget.eleveId,
                    onMatiereAdded: () {
                      _refresh();
                    },
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class OverallAverageHeader extends StatelessWidget {
  final AcademicSystem academicSystem;
  final String selectedPeriod;
  final String seriesLabel;
  final double? moyenne;
  final ValueChanged<String> onPeriodSelected;

  const OverallAverageHeader({
    super.key,
    required this.academicSystem,
    required this.selectedPeriod,
    required this.seriesLabel,
    required this.moyenne,
    required this.onPeriodSelected,
  });

  List<String> get periods {
    if (academicSystem == AcademicSystem.trimester) {
      return ['Trimestre 1', 'Trimestre 2', 'Trimestre 3', 'Annuelle'];
    } else {
      return ['Semestre 1', 'Semestre 2', 'Annuelle'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasData = moyenne != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'Moyennes calculées automatiquement',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: periods.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final period = periods[index];
              final bool isSelected = period == selectedPeriod;

              return ChoiceChip(
                label: Text(period),
                selected: isSelected,
                onSelected: (_) => onPeriodSelected(period),
                selectedColor: const Color(0xFF14284B),
                backgroundColor: const Color.fromARGB(255, 243, 242, 241),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF14284B),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFF14284B)
                        : (Colors.grey[400] ?? Colors.grey),
                  ),
                ),
                showCheckmark: false,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF14284B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Moyenne générale ($selectedPeriod)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withAlpha(153),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          hasData ? moyenne!.toStringAsFixed(2) : '--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/ 20',
                          style: TextStyle(
                            color: Colors.white.withAlpha(126),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAB308),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  seriesLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VueAnnuellePlaceholder extends StatelessWidget {
  const VueAnnuellePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(Icons.analytics_outlined, size: 48, color: Colors.grey[600]),
          const SizedBox(height: 12),
          const Text(
            'Récapitulatif Annuel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF14284B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Le récapitulatif annuel sera disponible prochainement.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
