import 'package:adminmaestropat/app/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDb {
  static addTodo(Product todomodel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection('products').add({
      'name': todomodel.name,
      'category': 0,
      'description': todomodel.description,
      'module': todomodel.module,
      'unit_measurement': todomodel.unitMeasurement,
      'variant': todomodel.variant
    });
  }

  static Stream<List<Product>> todoStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      return firebaseFirestore
          .collection('products')
          .snapshots()
          .map((QuerySnapshot query) {
        List<Product> todos = [];
        for (var todo in query.docs) {
          final todoModel =
              Product.fromDocumentSnapshot(documentSnapshot: todo);
          todos.add(todoModel);
        }
        return todos;
      });
    } catch (e) {
      print('Error en FirestoreDb.todoStream(): $e');

      return Stream.empty();
    }
  }

  static updateStatus(Product todomodel, documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('products').doc(documentId).update(
      {
        'name': todomodel.name,
        'category': 0,
        'description': todomodel.description,
        'module': todomodel.module,
        'unit_measurement': todomodel.unitMeasurement,
        'variant': todomodel.variant
      },
    );
  }

  static deleteTodo(String documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('products').doc(documentId).delete();
  }
}
