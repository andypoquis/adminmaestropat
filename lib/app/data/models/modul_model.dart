import 'package:cloud_firestore/cloud_firestore.dart';

class Modul {
  String? documentId;
  String? name;
  String? description;

  Modul({
    this.documentId,
    this.name,
    this.description,
  });

  Modul.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    name = documentSnapshot["name"];
    description = documentSnapshot["description"];
  }
}
