import 'package:assignment/src/core/constants/route_constants.dart';
import 'package:get/get.dart';

import '../../modules/random_user/presentation/controllers/random_user_binder.dart';
import '../../modules/random_user/presentation/screens/random_user_screen.dart';
class RandomUserRoutes {
  RandomUserRoutes._();

  static List<GetPage> get routes {
    return [
      GetPage(
        name: RouteConstants.randomUserScreen,
        page: () => const RandomUserScreen(),
        binding: RandomUserBindings(),
      ),
    ];
  }
}