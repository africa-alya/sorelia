import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorelia/core/security/limiteur_tentatives.dart';
import 'package:sorelia/core/security/pin_service.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorelia/screens/accueil.dart';
import 'package:sorelia/screens/inscription.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => ConnexionPageState();
}

class ConnexionPageState extends State<ConnexionPage> {
  static const Color primaryDark = Color(0xFF14284B);
  static const Color cardBg = Color(0xFFDCDFE5);
  static const Color inputBorderColor = Color(0xFF384A66);

  List<Student> _tousLesEleves = [];
  Student? _eleveSelectionne;
  final TextEditingController _pinController = TextEditingController();
  bool _obscurePin = true;
  String? _error;

  /// Vraie pendant la dérivation du PIN. Celle-ci prend plusieurs centaines de
  /// millisecondes, voire davantage sur un téléphone d'entrée de gamme
  /// (ADR-0005) : sans retour visuel, l'élève croirait le bouton mort.
  final bool _verificationEnCours = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chargerComptes();
  }

  Future<void> _chargerComptes() async {
    final comptes = await DatabaseHelper.instance.getAllEleves();
    final prefs = await SharedPreferences.getInstance();
    final dernierId = prefs.getInt('dernier_eleve_id');

    Student? selection;
    if (dernierId != null) {
      selection = comptes.where((e) => e.id == dernierId).firstOrNull;
    }
    selection ??= comptes.isNotEmpty ? comptes.first : null;

    setState(() {
      _tousLesEleves = comptes;
      _eleveSelectionne = selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/logos/onboarding.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Text(
                    "Bon retour !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 75),
                  // Sélecteur d'utilisateur
                  InkWell(
                    onTap: _ouvrirSelecteurComptes,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.5,
                            ),
                            radius: 20,
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: primaryDark,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _eleveSelectionne?.pseudonyme ??
                                      "Mes comptes",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: primaryDark,
                                  ),
                                ),
                                if (_eleveSelectionne != null)
                                  Text(
                                    '${_eleveSelectionne!.niveau} · Série ${_eleveSelectionne!.serie ?? "Tronc commun"}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: primaryDark,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  // Champ Code PIN
                  TextField(
                    controller: _pinController,
                    obscureText: _obscurePin,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(PinService.longueurPin),
                    ],
                    decoration: InputDecoration(
                      hintText: "Saisis ton code PIN",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: inputBorderColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: primaryDark,
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePin
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          color: primaryDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePin = !_obscurePin;
                          });
                        },
                      ),
                    ),
                  ),

                  // Lien Mot de passe oublié
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Action mot de passe oublié
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Code PIN oublié ?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      _error!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                  const SizedBox(height: 75),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _verificationEnCours ? null : _seConnecter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bouton secondaire Créer un compte
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const InscriptionPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Créer un nouveau compte",
                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                        color: primaryDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _ouvrirSelecteurComptes() async {
    final choisi = await showModalBottomSheet<Student>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "Choisir un compte",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryDark,
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: _tousLesEleves.map((e) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: cardBg,
                      child: Icon(Icons.person_outline, color: primaryDark),
                    ),
                    title: Text(
                      e.pseudonyme,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${e.niveau} · Série ${e.serie ?? "Tronc commun"}',
                    ),
                    onTap: () => Navigator.pop(ctx, e),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );

    if (choisi != null) {
      setState(() => _eleveSelectionne = choisi);
    }
  }

  Future<void> _seConnecter() async {
    // Réinitialiser l'erreur précédente
    setState(() => _error = null);

    // 1. Vérification de la sélection de l'élève
    final eleve = _eleveSelectionne;
    if (eleve?.id == null) {
      setState(() => _error = 'Veuillez sélectionner un compte.');
      return;
    }
    final eleveId = eleve!.id!;

    // 2. Vérification de la saisie du PIN
    final pinSaisi = _pinController.text.trim();
    if (pinSaisi.isEmpty) {
      setState(() => _error = 'Veuillez saisir votre code PIN.');
      return;
    }

    // 3. Vérification de la validité du PIN via le PinService (CORRECTION ICI)
    final pinValide = await PinService.verifier(pinSaisi, eleve.empreintePin);

    if (!pinValide) {
      // Optionnel : incrémenter le compteur d'échecs (US-007)
      await LimiteurTentatives.enregistrerEchec(eleveId);

      if (!mounted) return;
      setState(() => _error = 'Code PIN incorrect.');
      return;
    }

    // Le compteur d'échecs ne retombe que sur une connexion réussie.
    await LimiteurTentatives.reinitialiser(eleveId);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dernier_eleve_id', eleveId);

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => AccueilPage(eleveId: eleveId)),
      (route) => false,
    );
  }
}
