import 'package:adminmaestropat/app/ui/theme/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/products_controller.dart';

class ProductsPage extends GetView<ProductsController> {
  final controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => controller.navigationToProduct(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Obx(() => controller.products.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => controller.changedProductIndex(index),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      controller.products[index].name,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Modulo: ${controller.modules.firstWhere((element) => element.documentId == controller.products[index].module).name}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                Obx(() => Text(
                                      'Variantes: ${controller.products[index].variant.length}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    )),
                                Text(
                                  'Unidad de medida: ${controller.unitMeasurement.firstWhere((element) => element.documentId == controller.products[index].unitMeasurement).name}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: controller.products.length)
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
