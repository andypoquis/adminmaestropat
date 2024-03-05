import 'package:adminmaestropat/app/ui/pages/home_page/home_page.dart';
import 'package:adminmaestropat/app/ui/pages/modules_page/modules_page.dart';
import 'package:adminmaestropat/app/ui/pages/products_page/products_page.dart';
import 'package:adminmaestropat/app/ui/pages/profile_page/profile_page.dart';
import 'package:adminmaestropat/app/ui/pages/units_page/units_page.dart';
import 'package:adminmaestropat/app/ui/pages/users_page/users_page.dart';
import 'package:adminmaestropat/app/ui/theme/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/navigationmenu_controller.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../profile_page/profiles_page.dart';

class NavigationmenuPage extends GetView<NavigationmenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SliderDrawer(
                appBar: SliderAppBar(
                    appBarColor: Colors.white,
                    title: Obx(() => Text(
                        controller.listTitleMenuItem[
                            controller.selectIndexMenu.value],
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)))),
                slider: _silederUserWidget(),
                child: Container(
                  color: backgroundColor,
                  child: Obx(() => controller.selectIndexMenu.value == 0
                      ? HomePage()
                      : controller.selectIndexMenu.value == 1
                          ? UsersPage()
                          : controller.selectIndexMenu.value == 2
                              ? ProfilesPage()
                              : controller.selectIndexMenu.value == 3
                                  ? ProductsPage()
                                  : controller.selectIndexMenu.value == 4
                                      ? UnitsPage()
                                      : controller.selectIndexMenu.value == 5
                                          ? ModulesPage()
                                          : Container()),
                ))));
  }

  Widget _silederUserWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(scale: 3, controller.urlprofileUser.value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.nameUser.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text('Administrador')
                ],
              )),
          Flexible(
              flex: 3,
              child: Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () => controller.changedIndexMenu(index),
                            child: menuItem(index)),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: controller.listTitleMenuItem.length),
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  const Flexible(
                    flex: 1,
                    child: Center(
                      child: Row(children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cerrar sesión',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54),
                        )
                      ]),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget menuItem(int index) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: controller.selectIndexMenu.value == index
                  ? primaryColor[50]
                  : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            iconColor: controller.selectIndexMenu.value == index
                ? primaryColor[100]
                : Colors.black54,
            textColor: controller.selectIndexMenu.value == index
                ? primaryColor[100]
                : Colors.black54,
            leading: Icon(
              controller.iconsMenuItem[index],
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              controller.listTitleMenuItem[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget changedPageWidget() {
    switch (controller.selectIndexMenu.value) {
      case 0:
        return HomePage();
      case 1:
        return UsersPage();
      case 2:
        return ProductsPage();
      case 3:
        return UnitsPage();
      default:
        return HomePage();
    }
  }
}
