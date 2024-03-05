import 'package:adminmaestropat/app/data/services/modul_firestore.dart';
import 'package:adminmaestropat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/modul_model.dart';

class ModulesController extends GetxController {
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
    modulList.bindStream(ModulFirestore.todoStream());
    super.onReady();
  }

  changedUnitIndex(int index) {
    unitIndex.value = index;
    isEditing.value = true;
    nameController.text = modules[index].name!;
    descriptionController.text = modules[index].description!;

    Get.toNamed(Routes.MODUL);
  }

  navigationToUnit() {
    descriptionController.text = '';
    nameController.text = '';
    isEditing.value = false;
    Get.toNamed(Routes.MODUL);
  }

  addUnit() {
    ModulFirestore.addTodo(Modul(
        name: nameController.text, description: descriptionController.text));
    Get.back();
  }

  updateUnit() {
    ModulFirestore.updateStatus(
        Modul(
            name: nameController.text, description: descriptionController.text),
        modules[unitIndex.value].documentId);
    Get.back();
  }

  deleteUnit() {
    {
      ModulFirestore.deleteTodo(modules[unitIndex.value].documentId!);
      Get.back();
    }
  }
}
