class ListElements {
  int? id;
  String nom;
  String description;
  ListElements({this.id,required this.nom,required this.description });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "description": description,
    };
  }

  factory ListElements.fromMap(Map<String, dynamic> map) {
    return ListElements(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      );
  }
}
