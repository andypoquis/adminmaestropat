import 'package:adminmaestropat/app/ui/theme/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/units_controller.dart';

class UnitsPage extends GetView<UnitsController> {
  final controller = Get.put(UnitsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => controller.navigationToUnit(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Obx(() => controller.unitMeasurement.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => controller.changedUnitIndex(index),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      controller.unitMeasurement[index].name!,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() => Text(
                                      'Símbolo: ${controller.unitMeasurement[index].symbol!}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: controller.unitMeasurement.length)
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
