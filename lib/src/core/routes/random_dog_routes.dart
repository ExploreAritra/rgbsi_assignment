import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:assignment/src/modules/random_dog/presentation/controllers/random_dog_binder.dart';
import 'package:assignment/src/modules/random_dog/presentation/screens/random_dog_screen.dart';
import 'package:get/get.dart';

class RandomDogRoutes {
  RandomDogRoutes._();

  static List<GetPage> get routes {
    return [
      GetPage(
        name: RouteConstants.randomDogScreen,
        page: () => const RandomDogScreen(),
        binding: RandomDogBindings(),
      ),
    ];
  }
}
