import 'package:adminmaestropat/app/data/models/modul_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModulFirestore {
  static addTodo(Modul todomodel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection('modules').add({
      'name': todomodel.name,
      'description': todomodel.description,
    });
  }

  static Stream<List<Modul>> todoStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      return firebaseFirestore
          .collection('modules')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Modul> todos = [];
        for (var todo in query.docs) {
          final todoModel = Modul.fromDocumentSnapshot(documentSnapshot: todo);
          todos.add(todoModel);
        }
        return todos;
      });
    } catch (e) {
      print('Error en FirestoreDb.todoStream(): $e');

      return Stream.empty();
    }
  }

  static updateStatus(Modul todomodel, documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('modules').doc(documentId).update(
      {
        'name': todomodel.name,
        'description': todomodel.description,
      },
    );
  }

  static deleteTodo(String documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('measurement_units').doc(documentId).delete();
  }
}
