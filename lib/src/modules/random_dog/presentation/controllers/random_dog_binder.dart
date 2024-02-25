import 'package:assignment/src/modules/random_dog/presentation/controllers/random_dog_controller.dart';
import 'package:get/get.dart';

class RandomDogBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RandomDogController());
  }
}