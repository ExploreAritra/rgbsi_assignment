import 'package:assignment/src/core/routes/bluetooth_routes.dart';
import 'package:assignment/src/core/routes/main_route.dart';
import 'package:assignment/src/core/routes/random_dog_routes.dart';
import 'package:assignment/src/core/routes/random_user_routes.dart';
import 'package:get/get.dart';

class Routes {
  Routes._();

  static List<GetPage> get() {
    final moduleRoutes = <GetPage>[];
    moduleRoutes.addAll(MainRoutes.routes);
    moduleRoutes.addAll(RandomDogRoutes.routes);
    moduleRoutes.addAll(RandomUserRoutes.routes);
    moduleRoutes.addAll(BluetoothRoutes.routes);
    return moduleRoutes;
  }
}