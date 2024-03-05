
import 'package:get/get.dart';
import '../controllers/navigationmenu_controller.dart';


class NavigationmenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationmenuController>(() => NavigationmenuController());
  }
}