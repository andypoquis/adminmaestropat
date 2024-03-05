import 'package:adminmaestropat/app/ui/theme/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/modules_controller.dart';

class ModulesPage extends GetView<ModulesController> {
  final controller = Get.put(ModulesController());

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
          child: Obx(() => controller.modules.isNotEmpty
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
                                      controller.modules[index].name!,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() => Text(
                                      'Descripción: ${controller.modules[index].description!}',
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
                  itemCount: controller.modules.length)
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
