import 'package:flutter/material.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';

class ProfilPage extends StatefulWidget {
  final int? eleveId;
  const ProfilPage({super.key, this.eleveId});
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Student? _eleve;

  @override
  void initState() {
    super.initState();
    if (widget.eleveId != null) {
      _chargerEleve(widget.eleveId!);
    }
  }

  Future<void> _chargerEleve(int id) async {
    final eleve = await DatabaseHelper.instance.getEleveById(id);
    setState(() => _eleve = eleve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sorélia"), centerTitle: true),
      body: Center(child: Text("Profil de ${_eleve?.pseudonyme ?? 'User'}")),
    );
  }
}

