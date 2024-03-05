import 'package:adminmaestropat/app/bindings/auth_binding.dart';
import 'package:adminmaestropat/app/bindings/home_binding.dart';
import 'package:adminmaestropat/app/bindings/modules_binding.dart';
import 'package:adminmaestropat/app/bindings/navigationmenu_binding.dart';
import 'package:adminmaestropat/app/bindings/products_binding.dart';
import 'package:adminmaestropat/app/bindings/profile_binding.dart';
import 'package:adminmaestropat/app/bindings/units_binding.dart';
import 'package:adminmaestropat/app/bindings/users_binding.dart';
import 'package:adminmaestropat/app/ui/pages/auth_page/auth_page.dart';
import 'package:adminmaestropat/app/ui/pages/modules_page/modul_page.dart';
import 'package:adminmaestropat/app/ui/pages/navigationmenu_page/navigationmenu_page.dart';
import 'package:adminmaestropat/app/ui/pages/products_page/product_page.dart';
import 'package:adminmaestropat/app/ui/pages/profile_page/profile_page.dart';
import 'package:adminmaestropat/app/ui/pages/units_page/unit_page.dart';
import 'package:adminmaestropat/app/ui/pages/users_page/user_page.dart';
import 'package:get/get.dart';

import '../ui/pages/home_page/home_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.AUTH, page: () => AuthPage(), binding: AuthBinding()),
    GetPage(
        name: Routes.NAVIAGATIONMENU,
        page: () => NavigationmenuPage(),
        binding: NavigationmenuBinding()),
    GetPage(
        name: Routes.PRODUCT,
        page: () => ProductPage(),
        binding: ProductsBinding()),
    GetPage(name: Routes.UNIT, page: () => UnitPage(), binding: UnitsBinding()),
    GetPage(
        name: Routes.MODUL, page: () => ModulPage(), binding: ModulesBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(name: Routes.USER, page: () => UserPage(), binding: UsersBinding()),
  ];
}
