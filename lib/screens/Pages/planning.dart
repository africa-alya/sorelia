import 'package:flutter/material.dart';
import 'package:sorelia/data/local/app_datasource.dart';
import 'package:sorelia/domain/entities/eleves.dart';

class PlanningPage extends StatefulWidget {
  final int? eleveId;
  const PlanningPage({super.key, this.eleveId});
  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
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
      body: Center(child: Text("Planning de ${_eleve?.pseudonyme ?? 'User'}")),
    );
  }
}

