import 'package:adminmaestropat/app/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnitFirestore {
  static addTodo(UnitMeasurement todomodel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection('measurement_units').add({
      'name': todomodel.name,
      'symbol': todomodel.symbol,
    });
  }

  static Stream<List<UnitMeasurement>> todoStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      return firebaseFirestore
          .collection('measurement_units')
          .snapshots()
          .map((QuerySnapshot query) {
        List<UnitMeasurement> todos = [];
        for (var todo in query.docs) {
          final todoModel =
              UnitMeasurement.fromDocumentSnapshot(documentSnapshot: todo);
          todos.add(todoModel);
        }
        return todos;
      });
    } catch (e) {
      print('Error en FirestoreDb.todoStream(): $e');

      return Stream.empty();
    }
  }

  static updateStatus(UnitMeasurement todomodel, documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('measurement_units').doc(documentId).update(
      {'name': todomodel.name, 'symbol': todomodel.symbol},
    );
  }

  static deleteTodo(String documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('measurement_units').doc(documentId).delete();
  }
}
