import 'package:adminmaestropat/app/data/models/modul_model.dart';
import 'package:adminmaestropat/app/data/models/product_model.dart';
import 'package:adminmaestropat/app/data/models/unit_model.dart';
import 'package:adminmaestropat/app/data/services/modul_firestore.dart';
import 'package:adminmaestropat/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/db_firebase.dart';
import '../data/services/unit_firestore.dart';

class ProductsController extends GetxController {
  Rx<List<Product>> productsList = Rx<List<Product>>([]);
  List<Product> get products => productsList.value;

  Rx<List<UnitMeasurement>> unitMeasurementList = Rx<List<UnitMeasurement>>([]);
  List<UnitMeasurement> get unitMeasurement => unitMeasurementList.value;

  Rx<List<Modul>> modulList = Rx<List<Modul>>([]);
  List<Modul> get modules => modulList.value;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxBool isloading = false.obs;

  RxBool productNameFocused = false.obs;
  RxBool variantFocused = false.obs;

  Rx<UnitMeasurement> unitSelect = UnitMeasurement().obs;
  Rx<Modul> modulSelect = Modul().obs;

  late RxList<String> variants;
  late RxList<Modul> modulesSelect;

  TextEditingController productController = TextEditingController();
  TextEditingController varientController = TextEditingController();

  RxInt productIndex = 0.obs;
  RxBool isEditing = false.obs;

  changedProductIndex(int index) {
    productIndex.value = index;
    isEditing.value = true;
    productController.text = products[index].name;

    if (modules.isNotEmpty) {
      modulSelect.value = modules.firstWhere(
        (unit) => unit.documentId == products[index].module,
        orElse: () =>
            Modul(), // Devuelve un valor predeterminado si no se encuentra ningún elemento
      );
    }

    if (unitMeasurement.isNotEmpty) {
      unitSelect.value = unitMeasurement.firstWhere(
        (unit) => unit.documentId == products[index].unitMeasurement,
        orElse: () => UnitMeasurement(),
      );
    }

    variants.value = products[index].variant;

    Get.toNamed(Routes.PRODUCT);
  }

  @override
  void onReady() {
    productsList.bindStream(FirestoreDb.todoStream());
    unitMeasurementList.bindStream(UnitFirestore.todoStream());
    modulList.bindStream(ModulFirestore.todoStream());

    if (unitMeasurement.isNotEmpty) {
      unitSelect.value = unitMeasurement[0];
    }

    if (modules.isNotEmpty) {
      modulSelect.value = modules[0];
    }
    variants = <String>[].obs;

    super.onReady();
  }

  navigationToProduct() {
    productController.text = '';
    varientController.text = '';
    variants.value = [];
    isEditing.value = false;
    Get.toNamed(Routes.PRODUCT);
  }

  addVariant() {
    variants.add(varientController.text);
    update();
  }

  addModules() {
    modulesSelect.add(modulSelect.value);
    update();
  }

  deleteVariants(int index) {
    variants.removeAt(index);
    update();
  }

  deleteproduct() {
    {
      FirestoreDb.deleteTodo(products[productIndex.value].documentId!);
      Get.back();
    }
  }

  addProduct() {
    FirestoreDb.addTodo(Product(
        category: 0,
        description: '',
        module: modulSelect.value.documentId!,
        name: productController.text,
        unitMeasurement: unitSelect.value.documentId!,
        variant: variants));
    Get.back();
  }

  updateProduct() {
    FirestoreDb.updateStatus(
        Product(
            category: 0,
            description: '',
            module: modulSelect.value.documentId!,
            name: productController.text,
            unitMeasurement: unitSelect.value.documentId!,
            variant: variants),
        products[productIndex.value].documentId);
    Get.back();
  }

  updateUnitMeasure(String value) {
    unitSelect.value =
        unitMeasurement.firstWhere((unit) => unit.documentId == value);
    update();
  }

  updateModules(String value) {
    modulSelect.value = modules.firstWhere((unit) => unit.documentId == value);
    update();
  }
}
