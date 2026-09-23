import 'package:flutter/material.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';
import 'package:sorelia/domain/entities/matiere.dart';
import 'package:sorelia/domain/entities/seance_etude.dart';

class HomePage extends StatefulWidget {
  final int eleveId;
  const HomePage({super.key, required this.eleveId});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Student? _eleve;
  double? _moyenneGenerale;
  Matter? _pointFort;
  double? _moyennePointFort;
  Matter? _aRenforcer;
  double? _moyenneARenforcer;
  Etude? _prochaineSeance;
  bool _loading = true;

  static const Color primaryDark = Color(0xFF14284B);

  String getGreeting() {
    final heure = DateTime.now().hour;

    if (heure < 13) {
      return "Bonjour !";
    } else {
      return "Bonsoir !";
    }
  }

  @override
  void initState() {
    super.initState();
    _charger(widget.eleveId); // Appelé à tous les coups !
  }

  Future<void> _refresh() async {
    await _charger(widget.eleveId, isRefreshing: true);
  }

  Future<void> _charger(int id, {bool isRefreshing = false}) async {
    if (!isRefreshing) {
      setState(() => _loading = true);
    }

    final eleve = await DatabaseHelper.instance.getEleveById(id);
    final moyGenerale = await DatabaseHelper.instance.getMoyenneGenerale(
      widget.eleveId,
    );
    final prochaine = await DatabaseHelper.instance.getProchaineSeance(id);
    final matieres = await DatabaseHelper.instance.getMatieres(widget.eleveId);
    Matter? meilleure, plusFaible;
    double? moyMeilleure, moyPlusFaible;

    for (final m in matieres) {
      final moy = await DatabaseHelper.instance.getMoyenneMatiere(m.id!);
      if (moy == null) continue;
      if (moyMeilleure == null || moy > moyMeilleure) {
        meilleure = m;
        moyMeilleure = moy;
      }
      if (moyPlusFaible == null || moy < moyPlusFaible) {
        plusFaible = m;
        moyPlusFaible = moy;
      }
    }
    if (!mounted) return;
    setState(() {
      _eleve = eleve;
      _prochaineSeance = prochaine;
      _moyenneGenerale = moyGenerale;
      _pointFort = meilleure;
      _moyennePointFort = moyMeilleure;
      _aRenforcer = plusFaible;
      _moyenneARenforcer = moyPlusFaible;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // En-tête sous forme de bannière avec dégradé
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF132A4A), Color(0xFFE5A024)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getGreeting(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Text(
                          _eleve?.pseudonyme ?? 'User',
                          style: const TextStyle(
                            color: primaryDark,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFE5A024),
                      child: Text(
                        (_eleve?.pseudonyme != null &&
                                _eleve!.pseudonyme.isNotEmpty)
                            ? _eleve!.pseudonyme[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Ta progression',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
              const SizedBox(height: 12),

              // Cartes de progression
              Row(
                children: [
                  // Carte Moyenne générale (Sombre)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2A4A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moyenne générale',
                            style: TextStyle(
                              color: Colors.white.withAlpha(179),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                _moyenneGenerale == null
                                    ? '—'
                                    : _moyenneGenerale!
                                          .toStringAsFixed(1)
                                          .replaceAll('.', ','),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' / 20',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(153),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '',
                                  style: TextStyle(
                                    color: Color(0xFF166534),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'depuis juin dernier',
                            style: TextStyle(
                              color: Colors.white.withAlpha(128),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Carte Prochaine séance (Claire)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Prochaine séance',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _prochaineSeance?.matiere ?? 'Aucune',
                            style: const TextStyle(
                              color: Color(0xFFE5A024),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _prochaineSeance == null
                                ? '—'
                                : '${_prochaineSeance!.heureDebut} · ${_prochaineSeance!.dureeMin} min',
                            style: const TextStyle(
                              color: Color(0xFF334155),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Évolution de la moyenne',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
              const SizedBox(height: 12),

              _buildCard(
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _LineChartPainter(
                          moyenneGenerale: _moyenneGenerale,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'À retenir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 1. CARTE POINT FORT
              _CartePastille(
                icone: Icons.star_rounded,
                couleur: const Color(0xFF16A34A), // Vert
                label: 'Point fort',
                matiereNom: _pointFort?.nom ?? 'Aucun',
                note: _moyennePointFort,
              ),

              const SizedBox(height: 12),

              // 2. CARTE À RENFORCER
              _CartePastille(
                icone: Icons.arrow_drop_down_rounded,
                couleur: const Color(0xFFEF4444), // Rouge
                label: 'À renforcer',
                matiereNom: _aRenforcer?.nom ?? 'Aucune',
                note: _moyenneARenforcer,
              ),

              const SizedBox(height: 24),
              const Text(
                'Conseil du jour',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _aRenforcer != null
                    ? 'Planifie 2 séances courtes cette semaine. Commence par ${_aRenforcer!.nom.toLowerCase()}.'
                    : 'Ajoute des notes pour recevoir un conseil personnalisé.',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarteInfo extends StatelessWidget {
  final String titre;
  final String valeur;
  final Color couleurValeur;
  final String? sousTitre;

  const _CarteInfo({
    required this.titre,
    required this.valeur,
    required this.couleurValeur,
    this.sousTitre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(
            valeur,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: couleurValeur,
            ),
          ),
          if (sousTitre != null) ...[
            const SizedBox(height: 4),
            Text(
              sousTitre!,
              style: const TextStyle(fontSize: 11, color: Colors.black45),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartePastille extends StatelessWidget {
  final IconData icone;
  final Color couleur;
  final String label;
  final String matiereNom;
  final double? note;

  const _CartePastille({
    required this.icone,
    required this.couleur,
    required this.label,
    required this.matiereNom,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Petit Badge / Pilule en haut à gauche
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: couleur.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icone, size: 12, color: couleur),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: couleur,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 2. Ligne principale avec le Nom et la Note
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Nom de la matière
              Expanded(
                child: Text(
                  matiereNom,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    fontFamily: "Montserrat",
                  ),
                ),
              ),

              // Note + Chevron
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    note == null
                        ? '—'
                        : note!.toStringAsFixed(1).replaceAll('.', ','),
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: couleur,
                    ),
                  ),
                  const Text(
                    ' / 20',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right_rounded, color: couleur, size: 24),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: child,
  );
}

class _LineChartPainter extends CustomPainter {
  final double? moyenneGenerale;
  final double maxGrade;
  final double threshold;

  _LineChartPainter({
    required this.moyenneGenerale,
    this.maxGrade = 20.0,
    this.threshold = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dessin des axes (X et Y)
    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final pathAxis = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);
    canvas.drawPath(pathAxis, axisPaint);

    // 2. Gestion de l'absence de données dans la base
    if (moyenneGenerale == null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'Aucune note disponible',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2,
        ),
      );
      return;
    }

    // 3. Dessin de la ligne repère à 10/20
    final double thresholdY = size.height * (1 - (threshold / maxGrade));
    final thresholdPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, thresholdY),
      Offset(size.width, thresholdY),
      thresholdPaint,
    );

    // Label "10" à gauche de la ligne repère
    final label10Painter = TextPainter(
      text: const TextSpan(
        text: '10',
        style: TextStyle(color: Colors.grey, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label10Painter.paint(canvas, Offset(4, thresholdY - 12));

    // 4. Calcul de la hauteur selon la moyenne actuelle
    final clampedAvg = moyenneGenerale!.clamp(0.0, maxGrade);
    final double yPos = size.height * (1 - (clampedAvg / maxGrade));

    // Détermination de la couleur (Rouge si < 10, Vert si >= 10)
    final bool isPassing = clampedAvg >= threshold;
    final Color mainColor = isPassing
        ? const Color(0xFF0B6E4F)
        : const Color(0xFFD97706);

    // 5. Ligne horizontale représentant la moyenne actuelle
    final linePaint = Paint()
      ..color = mainColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, yPos), Offset(size.width, yPos), linePaint);

    // 6. Point indicateur au centre avec la valeur textuelle
    final pointPaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.5, yPos), 5.0, pointPaint);

    final scorePainter = TextPainter(
      text: TextSpan(
        text: '${clampedAvg.toStringAsFixed(1)} / 20',
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double textY = yPos - 18 < 0 ? yPos + 6 : yPos - 18;

    scorePainter.paint(
      canvas,
      Offset((size.width - scorePainter.width) / 2, textY),
    );
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.moyenneGenerale != moyenneGenerale;
  }
}
