import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationmenuController extends GetxController {
  RxInt selectIndexMenu = 0.obs;

  RxString urlprofileUser =
      'https://media.licdn.com/dms/image/D4E03AQGpTuwIouHlJA/profile-displayphoto-shrink_800_800/0/1691446168239?e=2147483647&v=beta&t=v4hhgyde8JXuSdMtkbMQVTubEvWu3Le654n8Qj5OBe4'
          .obs;
  RxString nameUser = 'Andrés E. Poquis Chávez'.obs;

  RxList<String> listTitleMenuItem = [
    'Inicio',
    'Usuarios',
    'Perfiles',
    'Productos',
    'Unidades de Medida',
    "Modulos"
  ].obs;
  RxList<IconData> iconsMenuItem = [
    Icons.home,
    Icons.group,
    Icons.groups_3,
    Icons.inventory_sharp,
    Icons.straighten,
    Icons.interests
  ].obs;

  changedIndexMenu(int index) {
    selectIndexMenu.value = index;
  }
}
