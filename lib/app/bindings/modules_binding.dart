
import 'package:get/get.dart';
import '../controllers/modules_controller.dart';


class ModulesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModulesController>(() => ModulesController());
  }
}