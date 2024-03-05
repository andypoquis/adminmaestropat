import 'package:adminmaestropat/app/ui/theme/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/users_controller.dart';

class UsersPage extends GetView<UsersController> {
  final controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => controller.navigationToUser(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Obx(() => controller.users.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => controller.changedUserIndex(index),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    scale: 3, controller.users[index].image),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => Text(
                                          controller.users[index].name,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Obx(() => Text(
                                          ' ${controller.profile.value}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        )),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: controller.users.length)
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
