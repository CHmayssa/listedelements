import 'package:flutter/material.dart';
import 'package:listedelements/model/Element.dart';
import 'package:listedelements/service/elementService.dart';

class ModifierElementScreen extends StatefulWidget {
  final int? elementId;
  const ModifierElementScreen({super.key, this.elementId});

  @override
  State<ModifierElementScreen> createState() => _ModifierElementScreen();
}

class _ModifierElementScreen extends State<ModifierElementScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future _loadUserData() async {
    if (widget.elementId != null) {
      final elements = await CruddataBase().getElementWithId(widget.elementId!);
      if (elements != null) {
        setState(() {
          nomController.text = elements.nom;
          descriptionController.text = elements.description;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification d\'un élèment'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom d'élément"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description d'élèment"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;

                if (nom.isNotEmpty &&  description.isNotEmpty) {
                  final utilisateur = ListElements(
                    id: widget.elementId,
                    nom: nom,
                    description: description,
                  );
                  await CruddataBase().updateElement(utilisateur);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mis à jour avec succès')),
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Erreur')),
                  );
                }
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
