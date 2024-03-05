import 'package:adminmaestropat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/unit_model.dart';
import '../data/services/unit_firestore.dart';

class UnitsController extends GetxController {
  Rx<List<UnitMeasurement>> unitMeasurementList = Rx<List<UnitMeasurement>>([]);
  List<UnitMeasurement> get unitMeasurement => unitMeasurementList.value;

  RxBool isEditing = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController symbolController = TextEditingController();

  RxBool unitNameFocused = false.obs;
  RxBool unitSymbolFocused = false.obs;

  RxInt unitIndex = 0.obs;

  @override
  void onReady() {
    unitMeasurementList.bindStream(UnitFirestore.todoStream());
    super.onReady();
  }

  changedUnitIndex(int index) {
    unitIndex.value = index;
    isEditing.value = true;
    nameController.text = unitMeasurement[index].name!;
    symbolController.text = unitMeasurement[index].symbol!;

    Get.toNamed(Routes.UNIT);
  }

  navigationToUnit() {
    isEditing.value = false;
    nameController.text = '';
    symbolController.text = '';
    Get.toNamed(Routes.UNIT);
  }

  addUnit() {
    UnitFirestore.addTodo(UnitMeasurement(
        name: nameController.text, symbol: symbolController.text));
    Get.back();
  }

  updateUnit() {
    UnitFirestore.updateStatus(
        UnitMeasurement(
            name: nameController.text, symbol: symbolController.text),
        unitMeasurement[unitIndex.value].documentId);
    Get.back();
  }

  deleteUnit() {
    {
      UnitFirestore.deleteTodo(unitMeasurement[unitIndex.value].documentId!);
      Get.back();
    }
  }
}
