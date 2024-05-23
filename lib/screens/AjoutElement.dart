import 'package:flutter/material.dart';
import 'package:listedelements/model/Element.dart';
import 'package:listedelements/service/elementService.dart';

class AddElements extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AddElements({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un élèment'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: (){},
          icon: const Icon(Icons.search)),
          IconButton(onPressed: (){},
          icon: const Icon(Icons.search)),
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom d'élèment"),
            ),
           
            TextField(
              controller: descriptionController,
              decoration:const InputDecoration(labelText: "Description d'élèment")
            ),
            const SizedBox(
              height:16,
            ),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final elements = ListElements(nom:nom, description: description);
                  await CruddataBase().insertElement(elements);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ajouter acvec succés')));
                    Navigator.pop(context,true);

                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content:Text('erreur')));
                }
              },  child: Text('Enregistrer') )
              
          ],
        ),
      ),
    );
  }
  
}

