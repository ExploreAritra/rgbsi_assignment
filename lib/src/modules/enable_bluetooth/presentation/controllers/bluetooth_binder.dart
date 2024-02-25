import 'package:assignment/src/modules/enable_bluetooth/presentation/controllers/bluetooth_controller.dart';
import 'package:get/get.dart';

class BluetoothBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BluetoothController());
  }
}