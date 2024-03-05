import 'package:adminmaestropat/app/data/services/modul_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/modul_model.dart';
import '../data/services/profil_firestore.dart';
import '../routes/app_pages.dart';

class ProfileController extends GetxController {
  Rx<List<Modul>> modulList = Rx<List<Modul>>([]);
  List<Modul> get modules => modulList.value;

  RxBool isEditing = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxBool unitNameFocused = false.obs;
  RxBool unitdescriptionFocused = false.obs;

  RxInt unitIndex = 0.obs;

  @override
  void onReady() {
    modulList.bindStream(ProfileFirestore.todoStream());
    super.onReady();
  }

  changedUnitIndex(int index) {
    unitIndex.value = index;
    isEditing.value = true;
    nameController.text = modules[index].name!;
    descriptionController.text = modules[index].description!;

    Get.toNamed(Routes.PROFILE);
  }

  navigationToUnit() {
    descriptionController.text = '';
    nameController.text = '';
    isEditing.value = false;
    Get.toNamed(Routes.PROFILE);
  }

  addUnit() {
    ProfileFirestore.addTodo(Modul(
        name: nameController.text, description: descriptionController.text));
    Get.back();
  }

  updateUnit() {
    ProfileFirestore.updateStatus(
        Modul(
            name: nameController.text, description: descriptionController.text),
        modules[unitIndex.value].documentId);
    Get.back();
  }

  deleteUnit() {
    {
      ProfileFirestore.deleteTodo(modules[unitIndex.value].documentId!);
      Get.back();
    }
  }
}
