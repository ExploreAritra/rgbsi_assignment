import 'package:assignment/src/core/connection/network_info.dart';
import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/network/api_base_helper.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:assignment/src/core/services/database/dao_session.dart';
import 'package:assignment/src/modules/random_dog/business/usecases/get_random_dog.dart';
import 'package:assignment/src/modules/random_dog/data/datasources/random_dog_local_data_source.dart';
import 'package:assignment/src/modules/random_dog/data/repositories/random_dog_repository_impl.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../business/entities/random_dog_entity.dart';
import '../../data/datasources/random_dog_remote_data_source.dart';

class RandomDogController extends GetxController {
  RandomDogController();

  Rx<RandomDogEntity?> randomDog = Rx<RandomDogEntity?>(null);
  Rx<Failure?> failure = Rx<Failure?>(null);
  Rx<bool> isLoading = Rx<bool>(false);
  Rx<bool> isRefreshClicked = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    eitherFailureOrRandomDog();
  }

  void refreshData() {
    eitherFailureOrRandomDog();
  }


  void eitherFailureOrRandomDog() async {
    RandomDogRepositoryImpl repository = RandomDogRepositoryImpl(
      remoteDataSource: RandomDogRemoteDataSourceImpl(apiHelper: ApiBaseHelper(dio: Dio())),
      localDataSource:
          RandomDogLocalDataSourceImpl(daoSession: Get.find<DaoSession>()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      dio: Dio(),
    );
    isLoading.value = true;
    update();
    final failureOrRandomDog =
        await GetRandomDog(randomDogRepository: repository)(
      randomDogParams: RandomDogParams(),
    );
    isLoading.value = false;
    failureOrRandomDog.fold(
      (newFailure) {
        randomDog.value = null;
        failure.value = newFailure;
        update();
      },
      (newRandomDog) {
        randomDog.value = newRandomDog;
        failure.value = null;
        update();
      },
    );
  }
}
