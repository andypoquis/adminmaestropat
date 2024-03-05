import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserFirestore {
  static addUser(UserModel userModel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection('users').doc(userModel.uid).set({
      'businessname': userModel.businessName,
      'dni': userModel.dni,
      'email': userModel.email,
      'image': userModel.image,
      'name': userModel.name,
      'phonenumber': userModel.phoneNumber,
      'profileid': userModel.profileId,
      'uid': userModel.uid,
    });
  }

  static Stream<List<UserModel>> userStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      return firebaseFirestore
          .collection('users')
          .snapshots()
          .map((QuerySnapshot query) {
        List<UserModel> users = [];
        for (var user in query.docs) {
          final userModel =
              UserModel.fromDocumentSnapshot(documentSnapshot: user);
          users.add(userModel);
        }
        return users;
      });
    } catch (e) {
      print('Error en UserFirestore.userStream(): $e');
      return Stream.empty();
    }
  }

  static updateUser(UserModel userModel, String documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('users').doc(documentId).update(
      {
        'businessname': userModel.businessName,
        'dni': userModel.dni,
        'email': userModel.email,
        'name': userModel.name,
        'phonenumber': userModel.phoneNumber,
        'profileid': userModel.profileId,
        'uid': userModel.uid,
      },
    );
  }

  static deleteUser(String documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    firebaseFirestore.collection('users').doc(documentId).delete();
  }
}
