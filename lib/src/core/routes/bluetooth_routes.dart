import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:assignment/src/modules/enable_bluetooth/presentation/controllers/bluetooth_binder.dart';
import 'package:assignment/src/modules/enable_bluetooth/presentation/screens/bluetooth_screen.dart';
import 'package:get/get.dart';

class BluetoothRoutes {
  BluetoothRoutes._();

  static List<GetPage> get routes {
    return [
      GetPage(
        name: RouteConstants.bluetoothScreen,
        page: () => const BluetoothScreen(),
        binding: BluetoothBindings(),
      ),
    ];
  }
}