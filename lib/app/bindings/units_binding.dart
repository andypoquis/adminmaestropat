
import 'package:get/get.dart';
import '../controllers/units_controller.dart';


class UnitsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitsController>(() => UnitsController());
  }
}