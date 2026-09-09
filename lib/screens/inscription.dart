import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorelia/core/security/pin_service.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';
import 'package:sorelia/screens/confidence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  // Garder en mémoire l'état du Form
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  List<String> _seriesDisponibles = [];

  // Contrôleurs de texte
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  static const Color primaryColor = Color(0xFF132A4A);
  static const Color labelColor = Color(0xFF1E293B);
  static const Color hintColor = Color(0xFF94A3B8);

  // Variables d'état
  bool _isPinObscured = true;
  bool _isConfirmPinObscured = true;

  // Valeurs sélectionnées par défaut
  String _selectedTeachingType = 'GENERAL';
  String _niveau = '3e';
  String? _serie;

  // Le clavier numérique n'empêche pas de coller des lettres : on filtre la
  // saisie elle-même, et on la borne à la longueur attendue.
  static final _formateursPin = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(PinService.longueurPin),
  ];

  // Liste deroulante
  final List<String> _teachingTypes = ['GENERAL', 'TECHNIQUE'];
  static const _niveaux = ['6e', '5e', '4e', '3e', '2nde', '1ere', 'Tle'];

  @override
  void initState() {
    super.initState();
    _chargerSeries(_niveau); // charge les séries dès l'ouverture
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "Crée un compte",
          style: TextStyle(
            color: primaryColor,
            fontFamily: "Montserrat",
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- PSEUDONYME ---
              _buildFieldLabel("Pseudonyme", isRequired: true),
              const SizedBox(height: 6),
              TextFormField(
                controller: _usernameController,
                decoration: _buildInputDecoration(hintText: "Ex : Awa02"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Veuillez entrer un pseudonyme";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 4),
              const Text(
                "Choisir un pseudonyme, pas ton propre nom !",
                style: TextStyle(color: hintColor, fontSize: 12),
              ),
              const SizedBox(height: 18),

              // --- TYPE D'ENSEIGNEMENT ---
              _buildFieldLabel("Type d'enseignement", isRequired: true),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedTeachingType,
                decoration: _buildInputDecoration(),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                elevation: 4,

                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: primaryColor,
                ),
                items: _teachingTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedTeachingType = value);
                  }
                },
              ),
              const SizedBox(height: 18),
              _buildFieldLabel("Niveau d'étude", isRequired: true),
              DropdownButtonFormField<String>(
                initialValue: _niveau,
                decoration: _buildInputDecoration(),
                items: _niveaux
                    .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                    .toList(),
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _niveau = v);
                  _chargerSeries(
                    v,
                  ); // ← recharge les séries à chaque changement
                },
              ),

              const SizedBox(height: 18),
              _buildFieldLabel("Série/Filière", isRequired: true),
              DropdownButtonFormField<String>(
                initialValue: _serie,
                decoration: _buildInputDecoration(),
                items: _seriesDisponibles
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(s == 'TRONC_COMMUN' ? 'Tronc commun' : s),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _serie = v),
                // Si vide, on peut afficher un message plutôt qu'un dropdown cassé
                disabledHint: _seriesDisponibles.isEmpty
                    ? const Text('')
                    : null,
              ),

              const SizedBox(height: 18),

              // --- CODE PIN ---
              _buildFieldLabel("Code PIN", isRequired: true),
              const SizedBox(height: 6),
              TextFormField(
                controller: _pinController,
                obscureText: _isPinObscured,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(
                  hintText: "Choisir un code PIN",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPinObscured
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() => _isPinObscured = !_isPinObscured);
                    },
                  ),
                ),
                inputFormatters: _formateursPin,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un code PIN";
                  }
                  if (value.length != PinService.longueurPin) {
                    return "Le code PIN doit contenir "
                        "exactement ${PinService.longueurPin} chiffres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // --- CONFIRMÉ PIN ---
              _buildFieldLabel("Confirmé PIN", isRequired: true),
              const SizedBox(height: 6),
              TextFormField(
                controller: _confirmPinController,
                obscureText: _isConfirmPinObscured,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(
                  hintText: "Choisir un code PIN",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPinObscured
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(
                        () => _isConfirmPinObscured = !_isConfirmPinObscured,
                      );
                    },
                  ),
                ),
                inputFormatters: _formateursPin,
                validator: (value) {
                  if (value != _pinController.text) {
                    return "Les codes PIN ne correspondent pas";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // --- TÉLÉPHONE (FACULTATIF) ---
              _buildFieldLabel("Téléphone (Facultatif)", isRequired: false),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _buildInputDecoration(
                  hintText: "Ex : 01 XX XX XX XX",
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontFamily: "Montserrat",
                  ),
                ),
              ],

              const SizedBox(height: 50),

              // --- BOUTON PRINCIPAL : CRÉER MON COMPTE ---
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Créer mon compte",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget pour les champs obligatoire ---
  Widget _buildFieldLabel(String label, {required bool isRequired}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: labelColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: "Montserrat",
        ),
        children: isRequired
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  Future<void> _chargerSeries(String niveau) async {
    final series = await DatabaseHelper.instance.getSeriesDisponibles(niveau);
    setState(() {
      _seriesDisponibles = series;
      // Si l'ancienne série n'existe plus pour ce niveau, on réinitialise
      if (!series.contains(_serie)) {
        _serie = series.isNotEmpty ? series.first : null;
      }
    });
  }

  // --- DÉCORATION COMMUNE POUR TOUS LES CHAMPS ---
  InputDecoration _buildInputDecoration({
    String? hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: hintColor, fontSize: 14),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF64748B), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  // --- TRAITEMENT DU FORMULAIRE ---
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_serie == null && _seriesDisponibles.isNotEmpty) {
      setState(() => _error = 'Choisis une série pour ce niveau.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final pseudonyme = _usernameController.text.trim();

      // Contrainte d'unicité, pas de l'authentification : deux comptes ne
      // peuvent pas partager le même pseudonyme sur cet appareil.
      final existeDeja = await DatabaseHelper.instance.pseudonymeExiste(
        pseudonyme,
      );
      if (existeDeja) {
        setState(() {
          _loading = false;
          _error = 'Ce pseudonyme est déjà utilisé sur cet appareil.';
        });
        return;
      }

      // Le PIN ne quitte jamais cet écran en clair : seule son empreinte est
      // persistée (ADR-0005). Le hachage tourne dans un isolate, d'où l'await
      // — l'indicateur de chargement du bouton couvre déjà cette attente.
      final eleve = Student(
        pseudonyme: pseudonyme,
        empreintePin: await PinService.hacher(_pinController.text.trim()),
        telephone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        niveau: _niveau,
        typeEnseignement: _selectedTeachingType,
      );

      final id = await DatabaseHelper.instance.createEleve(eleve);
      //await PinSecurity.saveSession(id);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('dernier_eleve_id', id);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte créé avec succès !')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ConfidencePage()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Une erreur est survenue, réessaie.';
      });
    }
  }
}
