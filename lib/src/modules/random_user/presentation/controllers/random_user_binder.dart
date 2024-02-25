import 'package:assignment/src/modules/random_user/presentation/controllers/random_user_controller.dart';
import 'package:get/get.dart';

class RandomUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RandomUserController());
  }
}