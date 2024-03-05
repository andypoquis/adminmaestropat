import 'package:cloud_firestore/cloud_firestore.dart';

class UnitMeasurement {
  String? documentId;
  String? name;
  String? symbol;

  UnitMeasurement({
    this.documentId,
    this.name,
    this.symbol,
  });

  UnitMeasurement.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    name = documentSnapshot["name"];
    symbol = documentSnapshot["symbol"];
  }
}
