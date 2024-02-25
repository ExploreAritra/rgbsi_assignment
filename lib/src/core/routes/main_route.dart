import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:assignment/src/main_screen.dart';
import 'package:get/get.dart';

class MainRoutes {
  MainRoutes._();

  static List<GetPage> get routes {
    return [
      GetPage(
        name: RouteConstants.mainScreen,
        page: () => const MainScreen(),
      ),
    ];
  }
}
