import 'package:adminmaestropat/app/data/services/profil_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/models/modul_model.dart';
import '../data/models/user_model.dart';
import '../data/services/user_firestore.dart';
import '../routes/app_pages.dart';

class UsersController extends GetxController {
  RxString nameUser = 'Andrés E. Poquis Chávez'.obs;
  RxString urlprofileUser =
      'https://media.licdn.com/dms/image/D4E03AQGpTuwIouHlJA/profile-displayphoto-shrink_800_800/0/1691446168239?e=2147483647&v=beta&t=v4hhgyde8JXuSdMtkbMQVTubEvWu3Le654n8Qj5OBe4'
          .obs;
  RxString profile = 'Administrador'.obs;
  RxBool isLoading = false.obs;

  Rx<List<UserModel>> userList = Rx<List<UserModel>>([]);
  List<UserModel> get users => userList.value;

  RxBool isEditing = false.obs;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController profileIdController = TextEditingController();
  TextEditingController uidController = TextEditingController();

  RxString imageUrl = ''.obs;

  RxInt userIndex = 0.obs;

  Rx<List<Modul>> profileList = Rx<List<Modul>>([]);
  List<Modul> get profiles => profileList.value;

  Rx<Modul> profileSelect = Modul().obs;

  @override
  void onReady() {
    userList.bindStream(UserFirestore.userStream());
    profileList.bindStream(ProfileFirestore.todoStream());

    if (profiles.isNotEmpty) {
      profileSelect.value = profiles[0];
    }
    super.onReady();
  }

  updateUnitMeasure(String value) {
    profileSelect.value =
        profiles.firstWhere((unit) => unit.documentId == value);
    update();
  }

  changedUserIndex(int index) {
    userIndex.value = index;
    isEditing.value = true;
    businessNameController.text = users[index].businessName!;
    imageUrl.value = users[index].image;
    dniController.text = users[index].dni!;
    emailController.text = users[index].email;
    nameController.text = users[index].name;
    phoneNumberController.text = users[index].phoneNumber;
    profileIdController.text = profileSelect.value.documentId!;
    uidController.text = users[index].uid;

    Get.toNamed(Routes.USER);
  }

  Future<void> registerUserToEmailPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      uidController.text = userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  navigationToUser() {
    businessNameController.text = '';
    dniController.text = '';
    emailController.text = '';
    nameController.text = '';
    phoneNumberController.text = '';
    profileIdController.text = '';
    uidController.text = '';
    isEditing.value = false;
    Get.toNamed(Routes.USER);
  }

  Future<void> addUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      UserFirestore.addUser(UserModel(
        businessName: businessNameController.text,
        dni: dniController.text,
        email: emailController.text,
        image:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        profileId: profileIdController.text,
        uid: userCredential.user!.uid,
      ));
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  updateUser() {
    UserFirestore.updateUser(
      UserModel(
        businessName: businessNameController.text,
        dni: dniController.text,
        email: emailController.text,
        image:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        profileId: profileIdController.text,
        uid: uidController.text,
      ),
      users[userIndex.value].uid,
    );
    Get.back();
  }

  deleteUser() {
    UserFirestore.deleteUser(users[userIndex.value].documentId!);
    Get.back();
  }
}
