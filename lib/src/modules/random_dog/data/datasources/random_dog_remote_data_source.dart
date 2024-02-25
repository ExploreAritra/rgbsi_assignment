import 'package:assignment/src/core/errors/exceptions.dart';
import 'package:assignment/src/core/network/api_base_helper.dart';
import 'package:assignment/src/core/network/url_endpoints.dart';
import 'package:assignment/src/core/params/params.dart';
import '../models/random_dog_model.dart';

abstract class RandomDogRemoteDataSource {
  Future<RandomDogModel> getRandomDog({required RandomDogParams randomDogParams});
}

class RandomDogRemoteDataSourceImpl implements RandomDogRemoteDataSource {
  final ApiBaseHelper apiHelper;

  RandomDogRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<RandomDogModel> getRandomDog({required RandomDogParams randomDogParams}) async {
    final response = await apiHelper.getRequest(
      UrlEndpoints.randomDogs,
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response?.statusCode == 200) {
      return RandomDogModel.fromJson(json: response?.data);
    } else {
      throw ServerException();
    }
  }
}
