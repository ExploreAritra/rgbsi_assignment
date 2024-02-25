import 'package:assignment/src/core/connection/network_info.dart';
import 'package:assignment/src/core/errors/failure.dart';
import 'package:assignment/src/core/network/api_base_helper.dart';
import 'package:assignment/src/core/params/params.dart';
import 'package:assignment/src/core/services/database/dao_session.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../business/entities/random_user_entity.dart';
import '../../business/usecases/get_random_user.dart';
import '../../data/datasources/random_user_local_data_source.dart';
import '../../data/datasources/random_user_remote_data_source.dart';
import '../../data/repositories/random_user_repository_impl.dart';

class RandomUserController extends GetxController {
  RandomUserController();

  Rx<RandomUserEntity?> randomUser = Rx<RandomUserEntity?>(null);
  Rx<Failure?> failure = Rx<Failure?>(null);
  Rx<bool> isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    eitherFailureOrRandomUser();
  }

  void refreshData() {
    eitherFailureOrRandomUser();
  }


  void eitherFailureOrRandomUser() async {
    RandomUserRepositoryImpl repository = RandomUserRepositoryImpl(
      remoteDataSource: RandomUserRemoteDataSourceImpl(apiHelper: ApiBaseHelper(dio: Dio())),
      localDataSource:
          RandomUserLocalDataSourceImpl(daoSession: Get.find<DaoSession>()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker(),),
      dio: Dio(),
    );
    isLoading.value = true;
    update();
    final failureOrRandomUser =
        await GetRandomUser(randomUserRepository: repository)(
      randomUserParams: RandomUserParams(),
    );
    isLoading.value = false;
    failureOrRandomUser.fold(
      (newFailure) {
        randomUser.value = null;
        failure.value = newFailure;
        update();
      },
      (newRandomUser) {
        randomUser.value = newRandomUser;
        failure.value = null;
        update();
      },
    );
  }
}
