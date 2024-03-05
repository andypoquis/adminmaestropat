import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? documentId;
  String? businessName;
  String? dni;
  late String email;
  late String image;
  late String name;
  late String phoneNumber;
  late String profileId;
  late String uid;

  UserModel({
    this.documentId,
    this.businessName,
    this.dni,
    required this.image,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.profileId,
    required this.uid,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessname'] ?? '';
    dni = json['dni'] ?? '';
    email = json['email'] ?? '';
    name = json['name'] ?? '';
    phoneNumber = json['phonenumber'] ?? '';
    profileId = json['profileid'] ?? '';
    uid = json['uid'] ?? '';
  }

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    businessName = documentSnapshot["businessname"] ?? '';
    dni = documentSnapshot["dni"] ?? '';
    email = documentSnapshot["email"] ?? '';
    image = documentSnapshot["image"] ??
        'https://www.iconpacks.net/icons/1/free-user-icon-295-thumb.png';
    name = documentSnapshot["name"] ?? '';
    phoneNumber = documentSnapshot["phonenumber"] ?? '';
    profileId = documentSnapshot["profileid"] ?? '';
    uid = documentSnapshot["uid"] ?? '';
  }
}
