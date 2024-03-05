import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? documentId;
  late int category;
  late String description;
  late String module;
  late String name;
  late String unitMeasurement;
  late List<String> variant;

  Product({
    this.documentId,
    required this.category,
    required this.description,
    required this.module,
    required this.name,
    required this.unitMeasurement,
    required this.variant,
  });

  Product.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    category = documentSnapshot["category"];
    description = documentSnapshot["description"];
    module = documentSnapshot["module"];
    name = documentSnapshot["name"];
    unitMeasurement = documentSnapshot["unit_measurement"];
    variant = List<String>.from(documentSnapshot["variant"] ?? []);
  }
}
